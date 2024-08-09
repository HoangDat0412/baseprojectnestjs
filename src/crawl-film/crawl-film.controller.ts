import { Controller, Get, Query } from '@nestjs/common';
import { CrawlFilmService } from './crawl-film.service';

@Controller('crawl-film')
export class CrawlFilmController {
  constructor(private readonly crawlFilmService: CrawlFilmService) {}

  @Get('films')
  async crawlFilms(
    @Query('startPage') startPage: number,
    @Query('endPage') endPage: number,
  ) {
    const films = await this.crawlFilmService.crawlFilms(startPage, endPage);
    return { status: true, films };
  }

}
