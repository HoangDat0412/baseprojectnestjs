import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateUserDto } from './dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async createUser(data: CreateUserDto) {
    const hashedPassword = await bcrypt.hash(data.password, 10);
    data.password = hashedPassword;
    data.role = 'User';
    const { password, ...result } = await this.prisma.user.create({
      data,
    });
    return result;
  }

  async getUser(id: number): Promise<any | null> {
    return this.prisma.user.findUnique({
      where: { user_id: id },
    });
  }
}
