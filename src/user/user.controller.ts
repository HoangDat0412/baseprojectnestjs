import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  UseGuards,
  Req,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { RolesGuard } from 'src/auth/guards/roles.guard';
import { Roles } from 'src/auth/guards/roles.decorator';
import { FileInterceptor } from '@nestjs/platform-express';
import { multerConfig } from 'src/common/uploadfile/multer.config';
import { PrismaService } from 'src/prisma/prisma.service';
// import { User } from '@prisma/client';

@Controller('users')
export class UserController {
  constructor(
    private readonly userService: UserService,
    private readonly prisma: PrismaService,
  ) {}

  @Get()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('Admin')
  async getAll() {
    return 'All User';
  }

  @Post('avatar')
  // @UseGuards(JwtAuthGuard)
  @UseInterceptors(FileInterceptor('avatar', multerConfig))
  async uploadAvatar(@UploadedFile() file: Express.Multer.File) {
    // Assuming the file is saved to 'uploads' folder
    const avatarUrl = `/uploads/avatars/${file.filename}`;
    // Update user with the avatar URL
    // await this.prisma.user.update({
    //   where: { id: userId },
    //   data: { avatarUrl },
    // });

    return { url: avatarUrl };
  }

  @Post()
  async createUser(@Body() userData: CreateUserDto): Promise<any> {
    return this.userService.createUser(userData);
  }

  @Get(':id')
  async getUser(@Param('id') id: string): Promise<any> {
    return this.userService.getUser(Number(id));
  }
}
