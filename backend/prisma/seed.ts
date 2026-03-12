import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import 'dotenv/config'; // Pastikan env terbaca

const prisma = new PrismaClient({
  log: ['info', 'warn', 'error'],
});

async function main() {
  console.log('Start seeding...');

  // Kita hash password ini agar sesuai dengan standar keamanan login
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash('password123', salt);

  const user = await prisma.user.upsert({
    where: { email: 'kevin@gmail.com' },
    update: {}, 
    create: {
      email: 'kevin@gmail.com',
      password: hashedPassword,
      fullName: 'KEVIN YULIAN PAMUNGKAS',
      wallet: {
        create: {
          accountNumber: '7341230048', 
          balance: 25500000,
        },
      },
    },
  });

  console.log('User Created:', user);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
