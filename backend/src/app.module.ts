// c:\Users\KIDUNG\Documents\Projects Developer\Flutter-mBanking\backend\src\app.module.ts
// (Contoh file, sesuaikan dengan file Anda)

import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { WalletModule } from './wallet/wallet.module';
import { PrismaModule } from './wallet/prisma.module'; // <-- Tambahkan import ini

@Module({
  imports: [
    PrismaModule, // <-- Daftarkan di sini
    WalletModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
