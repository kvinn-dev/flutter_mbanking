// c:\Users\KIDUNG\Documents\Projects Developer\Flutter-mBanking\backend\src\app.module.ts
// (Contoh file, sesuaikan dengan file Anda)

import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { WalletModule } from './wallet/wallet.module';
import { PrismaModule } from '../prisma/prisma.module'; // <-- Tambahkan import ini
import { AuthModule } from './auth/auth.module';

@Module({
  imports: [
    PrismaModule, // <-- Daftarkan di sini
    WalletModule,
    AuthModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
