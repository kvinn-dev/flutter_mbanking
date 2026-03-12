import { Injectable, UnauthorizedException, Logger } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service'; // Sesuaikan path jika perlu
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async login(email: string, pass: string) {
    console.time('Total Login Process'); // START TIMER

    console.time('DB: Find User');
    // 1. Optimized Query: Fetch only what's needed using select
    const user = await this.prisma.user.findUnique({
      where: { email },
      select: {
        id: true,
        email: true,
        password: true,
        fullName: true,
        wallet: {
          select: {
            balance: true,
          },
        },
      },
    });
    console.timeEnd('DB: Find User'); // STOP TIMER DB

    if (!user) {
      this.logger.warn(`Failed login attempt for email: ${email} (User not found)`);
      throw new UnauthorizedException('Invalid credentials');
    }

    console.time('CPU: Bcrypt Compare');
    // 2. Validate Password
    const isMatch = await bcrypt.compare(pass, user.password);
    console.timeEnd('CPU: Bcrypt Compare'); // STOP TIMER BCRYPT

    if (!isMatch) {
      this.logger.warn(`Failed login attempt for email: ${email} (Invalid password)`);
      throw new UnauthorizedException('Invalid credentials');
    }

    // 3. Generate Token
    console.time('CPU: Sign JWT');
    const payload = { sub: user.id, email: user.email };
    const token = await this.jwtService.signAsync(payload);
    console.timeEnd('CPU: Sign JWT');
    
    console.timeEnd('Total Login Process'); // STOP TOTAL

    // 4. Return formatted response for Flutter
    return {
      user_id: user.id,
      name: user.fullName,
      email: user.email,
      // Prisma Decimal might need conversion to number/string for JSON
      balance: user.wallet?.balance ? Number(user.wallet.balance) : 0, 
      token,
    };
  }
}
