// backend/src/wallet/wallet.service.ts
import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service'; 

@Injectable()
export class WalletService {
  constructor(private prisma: PrismaService) {}

  async getBalance(userId: number) {
    return this.prisma.wallet.findUnique({
      where: { userId },
      include: {
        sentTransactions: { orderBy: { createdAt: 'desc' }, take: 5 },
        receivedTransactions: { orderBy: { createdAt: 'desc' }, take: 5 },
      },
    });
  }

  // Transfer Sesama Bank
  async transferIntraBank(senderUserId: number, targetAccountNumber: string, amount: number) {
    return this.prisma.$transaction(async (tx) => {
      // 1. Cek Sender
      const senderWallet = await tx.wallet.findUnique({ where: { userId: senderUserId } });
      if (!senderWallet) throw new BadRequestException('Wallet not found');
      
      if (Number(senderWallet.balance) < amount) {
        throw new BadRequestException('Insufficient balance');
      }

      // 2. Cek Receiver
      const receiverWallet = await tx.wallet.findUnique({ where: { accountNumber: targetAccountNumber } });
      if (!receiverWallet) throw new BadRequestException('Receiver not found');

      // 3. Kurangi Saldo Sender
      await tx.wallet.update({
        where: { id: senderWallet.id },
        data: { balance: { decrement: amount } },
      });

      // 4. Tambah Saldo Receiver
      await tx.wallet.update({
        where: { id: receiverWallet.id },
        data: { balance: { increment: amount } },
      });

      // 5. Catat Transaksi
      return tx.transaction.create({
        data: {
          amount: amount,
          type: 'TRANSFER_INTRA',
          senderWalletId: senderWallet.id,
          receiverWalletId: receiverWallet.id,
          description: `Transfer to ${receiverWallet.accountNumber}`,
        },
      });
    });
  }
}
