// c:\Users\KIDUNG\Documents\Projects Developer\Flutter-mBanking\backend\src\wallet\wallet.controller.ts

import { Controller, Get, Post, Body, BadRequestException } from '@nestjs/common';
import { WalletService } from './wallet.service';

@Controller('wallet')
export class WalletController {
  constructor(private readonly walletService: WalletService) {}

  @Get('me')
  async getMyBalance() {
    // TODO: Nanti ganti ID ini dengan req.user.id dari JWT Auth Guard
    // Untuk testing sekarang, kita hardcode ke User ID 1 (User A)
    const userId = 1; 
    
    return this.walletService.getBalance(userId);
  }

  @Post('transfer')
  async transfer(@Body() body: { toAccount: string; amount: number }) {
    // TODO: Nanti ganti ID ini dengan req.user.id
    const senderId = 1; 
    
    return this.walletService.transferIntraBank(senderId, body.toAccount, Number(body.amount));
  }
}
