import { Module } from '@nestjs/common';
import { CrawlFilmService } from './crawl-film.service';
import { CrawlFilmController } from './crawl-film.controller';

@Module({
  providers: [CrawlFilmService],
  controllers: [CrawlFilmController]
})
export class CrawlFilmModule {}
