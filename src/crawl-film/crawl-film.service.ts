import { Injectable } from '@nestjs/common';
import axios from 'axios';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CrawlFilmService {
  private readonly baseUrl = 'https://ophim1.com';

  constructor(private readonly prisma: PrismaService) {}

  async crawlFilms(startPage: number, endPage: number): Promise<any[]> {
    const films = [];

    for (let page = startPage; page <= endPage; page++) {
      const pageData = await this.getFilmsByPage(page);

      for (const film of pageData) {
        try {
          const filmDetails = await this.getFilmDetails(film.slug);
          await this.saveFilmToDatabase(filmDetails);
          films.push(filmDetails);
        } catch (error) {
          console.error(`Error processing film ${film.slug}:`, error);
          // Continue to the next film
        }
      }
    }

    return films;
  }

  private async getFilmsByPage(page: number): Promise<any> {
    try {
      const response = await axios.get(
        `${this.baseUrl}/danh-sach/phim-moi-cap-nhat?page=${page}`,
      );
      return response.data.items;
    } catch (error) {
      console.error(`Error fetching data for page ${page}:`, error);
      throw new Error('Failed to fetch data');
    }
  }

  async getFilmDetails(slug: string): Promise<any> {
    try {
      const response = await axios.get(`${this.baseUrl}/phim/${slug}`);
      console.log(response.data);

      return response.data;
    } catch (error) {
      console.error(`Error fetching film details for slug ${slug}:`, error);
      throw new Error('Failed to fetch film details');
    }
  }

  private async saveFilmToDatabase(filmDetails: any) {
    const {
      name,
      trailer_url,
      time,
      episode_current,
      episode_total,
      quality,
      lang,
      notify,
      showtimes,
      origin_name,
      content,
      type,
      status,
      thumb_url,
      poster_url,
      year,
      view,
      is_copyright,
      chieurap,
      sub_docquyen,
      actor,
      director,
      category,
      country,
      slug,
      tmdb,
    } = filmDetails.movie;
    const des = content.replace(/<\/?p>/g, '');
    const { episodes } = filmDetails;
    // Save movie
    let movie;
    try {
      movie = await this.prisma.movie.create({
        data: {
          name,
          origin_name,
          content: des,
          type,
          status,
          thumb_url,
          poster_url,
          year: parseInt(year),
          view,
          is_copyright,
          chieurap,
          sub_docquyen,
          slug,
          trailer_url,
          duration: time,
          episode_current,
          episode_total,
          quality,
          lang,
          notify,
          showtimes,
          tmdb_vote_count: parseInt(tmdb.vote_count),
          tmdb_vote_average: parseFloat(tmdb.vote_average),
        },
      });
    } catch (error) {
      console.error(`Error saving movie ${name}:`, error);
      return; // Skip the rest of the processing for this film
    }

    // Save actors
    for (const actorName of actor) {
      try {
        let actor = await this.prisma.actor.findFirst({
          where: { name: actorName },
        });
        if (!actor) {
          actor = await this.prisma.actor.create({ data: { name: actorName } });
        }
        await this.prisma.movieActor.create({
          data: { movie_id: movie.movie_id, actor_id: actor.actor_id },
        });
      } catch (error) {
        console.error(`Error saving actor ${actorName}:`, error);
        // Continue to the next actor
      }
    }

    // Save directors
    for (const directorName of director) {
      try {
        let director = await this.prisma.director.findFirst({
          where: { name: directorName },
        });
        if (!director) {
          director = await this.prisma.director.create({
            data: { name: directorName },
          });
        }
        await this.prisma.movieDirector.create({
          data: { movie_id: movie.movie_id, director_id: director.director_id },
        });
      } catch (error) {
        console.error(`Error saving director ${directorName}:`, error);
        // Continue to the next director
      }
    }

    // Save genres
    for (const genre of category) {
      try {
        let genreEntry = await this.prisma.genre.findUnique({
          where: { name: genre.name },
        });
        if (!genreEntry) {
          genreEntry = await this.prisma.genre.create({
            data: { name: genre.name, slug: genre.slug },
          });
        }
        await this.prisma.movieGenre.create({
          data: { movie_id: movie.movie_id, genre_id: genreEntry.genre_id },
        });
      } catch (error) {
        console.error(`Error saving genre ${genre.name}:`, error);
        // Continue to the next genre
      }
    }

    // Save countries
    for (const countryEntry of country) {
      try {
        let country = await this.prisma.country.findUnique({
          where: { name: countryEntry.name },
        });
        if (!country) {
          country = await this.prisma.country.create({
            data: { name: countryEntry.name, slug: countryEntry.slug },
          });
        }
        await this.prisma.movieCountry.create({
          data: { movie_id: movie.movie_id, country_id: country.country_id },
        });
      } catch (error) {
        console.error(`Error saving country ${countryEntry.name}:`, error);
        // Continue to the next country
      }
    }

    // Save episodes
    for (const episode of episodes[0].server_data) {
      try {
        await this.prisma.episode.create({
          data: {
            movie_id: movie.movie_id,
            server_name: episodes[0].server_name,
            name: episode.name,
            slug: episode.slug,
            filename: episode.filename,
            link_film: episode.link_embed,
          },
        });
      } catch (error) {
        console.error(`Error saving episode ${episode.name}:`, error);
        // Continue to the next episode
      }
    }
  }
}
