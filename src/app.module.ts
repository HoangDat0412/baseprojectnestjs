import { Module } from '@nestjs/common';
import { PrismaModule } from './prisma/prisma.module';
import { UserModule } from './user/user.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { CrawlFilmModule } from './crawl-film/crawl-film.module';
// import { ServeStaticModule } from '@nestjs/serve-static';
// import { join } from 'path';
@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    PrismaModule,
    UserModule,
    AuthModule,
    CrawlFilmModule,
  ],
  controllers: [],
})
export class AppModule {}
