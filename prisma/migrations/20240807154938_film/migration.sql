/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[username]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[google_id]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[facebook_id]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `username` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "id",
DROP COLUMN "updatedAt",
ADD COLUMN     "avatar_url" TEXT,
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "facebook_id" TEXT,
ADD COLUMN     "full_name" TEXT,
ADD COLUMN     "google_id" TEXT,
ADD COLUMN     "is_2fa" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "is_verify" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "user_id" SERIAL NOT NULL,
ADD COLUMN     "username" TEXT NOT NULL,
ALTER COLUMN "role" SET DEFAULT 'user',
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("user_id");

-- CreateTable
CREATE TABLE "Movie" (
    "movie_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "origin_name" TEXT,
    "content" TEXT,
    "type" TEXT NOT NULL DEFAULT 'single',
    "status" TEXT,
    "thumb_url" TEXT,
    "trailer_url" TEXT,
    "duration" TEXT,
    "episode_current" TEXT,
    "episode_total" TEXT,
    "quality" TEXT,
    "lang" TEXT,
    "notify" TEXT,
    "showtimes" TEXT,
    "slug" TEXT NOT NULL,
    "year" INTEGER,
    "view" INTEGER NOT NULL DEFAULT 0,
    "is_copyright" BOOLEAN NOT NULL DEFAULT false,
    "chieurap" BOOLEAN NOT NULL DEFAULT false,
    "poster_url" TEXT,
    "sub_docquyen" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Movie_pkey" PRIMARY KEY ("movie_id")
);

-- CreateTable
CREATE TABLE "Episode" (
    "episode_id" SERIAL NOT NULL,
    "movie_id" INTEGER NOT NULL,
    "server_name" TEXT,
    "name" TEXT,
    "slug" TEXT NOT NULL,
    "filename" TEXT,
    "link_film" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Episode_pkey" PRIMARY KEY ("episode_id")
);

-- CreateTable
CREATE TABLE "Genre" (
    "genre_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT,

    CONSTRAINT "Genre_pkey" PRIMARY KEY ("genre_id")
);

-- CreateTable
CREATE TABLE "MovieGenre" (
    "movie_id" INTEGER NOT NULL,
    "genre_id" INTEGER NOT NULL,

    CONSTRAINT "MovieGenre_pkey" PRIMARY KEY ("movie_id","genre_id")
);

-- CreateTable
CREATE TABLE "Country" (
    "country_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT,

    CONSTRAINT "Country_pkey" PRIMARY KEY ("country_id")
);

-- CreateTable
CREATE TABLE "MovieCountry" (
    "movie_id" INTEGER NOT NULL,
    "country_id" INTEGER NOT NULL,

    CONSTRAINT "MovieCountry_pkey" PRIMARY KEY ("movie_id","country_id")
);

-- CreateTable
CREATE TABLE "Actor" (
    "actor_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Actor_pkey" PRIMARY KEY ("actor_id")
);

-- CreateTable
CREATE TABLE "MovieActor" (
    "movie_id" INTEGER NOT NULL,
    "actor_id" INTEGER NOT NULL,

    CONSTRAINT "MovieActor_pkey" PRIMARY KEY ("movie_id","actor_id")
);

-- CreateTable
CREATE TABLE "Director" (
    "director_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Director_pkey" PRIMARY KEY ("director_id")
);

-- CreateTable
CREATE TABLE "MovieDirector" (
    "movie_id" INTEGER NOT NULL,
    "director_id" INTEGER NOT NULL,

    CONSTRAINT "MovieDirector_pkey" PRIMARY KEY ("movie_id","director_id")
);

-- CreateTable
CREATE TABLE "Rating" (
    "rating_id" SERIAL NOT NULL,
    "movie_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "score" INTEGER NOT NULL,
    "review" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Rating_pkey" PRIMARY KEY ("rating_id")
);

-- CreateTable
CREATE TABLE "Comment" (
    "comment_id" SERIAL NOT NULL,
    "movie_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "parent_comment_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("comment_id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "notification_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "message" TEXT NOT NULL,
    "read" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("notification_id")
);

-- CreateTable
CREATE TABLE "Advertisement" (
    "ad_id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT,
    "image_url" TEXT,
    "target_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Advertisement_pkey" PRIMARY KEY ("ad_id")
);

-- CreateTable
CREATE TABLE "WatchHistory" (
    "history_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "movie_id" INTEGER NOT NULL,
    "watched_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WatchHistory_pkey" PRIMARY KEY ("history_id")
);

-- CreateTable
CREATE TABLE "Permission" (
    "permission_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "permission" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("permission_id")
);

-- CreateTable
CREATE TABLE "ActivityLog" (
    "log_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "action" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ActivityLog_pkey" PRIMARY KEY ("log_id")
);

-- CreateTable
CREATE TABLE "Category" (
    "category_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("category_id")
);

-- CreateTable
CREATE TABLE "CategoryMovie" (
    "category_id" INTEGER NOT NULL,
    "movie_id" INTEGER NOT NULL,
    "added_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CategoryMovie_pkey" PRIMARY KEY ("category_id","movie_id")
);

-- CreateTable
CREATE TABLE "Blog" (
    "blog_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "movie_id" INTEGER,
    "image_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Blog_pkey" PRIMARY KEY ("blog_id")
);

-- CreateTable
CREATE TABLE "BlogComment" (
    "comment_id" SERIAL NOT NULL,
    "blog_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "parent_comment_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BlogComment_pkey" PRIMARY KEY ("comment_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Movie_slug_key" ON "Movie"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Episode_slug_key" ON "Episode"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Genre_name_key" ON "Genre"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Genre_slug_key" ON "Genre"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Country_name_key" ON "Country"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Country_slug_key" ON "Country"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_google_id_key" ON "User"("google_id");

-- CreateIndex
CREATE UNIQUE INDEX "User_facebook_id_key" ON "User"("facebook_id");

-- AddForeignKey
ALTER TABLE "Episode" ADD CONSTRAINT "Episode_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MovieGenre" ADD CONSTRAINT "MovieGenre_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MovieGenre" ADD CONSTRAINT "MovieGenre_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "Genre"("genre_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MovieCountry" ADD CONSTRAINT "MovieCountry_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MovieCountry" ADD CONSTRAINT "MovieCountry_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "Country"("country_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MovieActor" ADD CONSTRAINT "MovieActor_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MovieActor" ADD CONSTRAINT "MovieActor_actor_id_fkey" FOREIGN KEY ("actor_id") REFERENCES "Actor"("actor_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MovieDirector" ADD CONSTRAINT "MovieDirector_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MovieDirector" ADD CONSTRAINT "MovieDirector_director_id_fkey" FOREIGN KEY ("director_id") REFERENCES "Director"("director_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rating" ADD CONSTRAINT "Rating_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rating" ADD CONSTRAINT "Rating_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "Comment"("comment_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WatchHistory" ADD CONSTRAINT "WatchHistory_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WatchHistory" ADD CONSTRAINT "WatchHistory_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Permission" ADD CONSTRAINT "Permission_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ActivityLog" ADD CONSTRAINT "ActivityLog_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CategoryMovie" ADD CONSTRAINT "CategoryMovie_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("category_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CategoryMovie" ADD CONSTRAINT "CategoryMovie_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Blog" ADD CONSTRAINT "Blog_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Blog" ADD CONSTRAINT "Blog_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlogComment" ADD CONSTRAINT "BlogComment_blog_id_fkey" FOREIGN KEY ("blog_id") REFERENCES "Blog"("blog_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlogComment" ADD CONSTRAINT "BlogComment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlogComment" ADD CONSTRAINT "BlogComment_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "BlogComment"("comment_id") ON DELETE SET NULL ON UPDATE CASCADE;
