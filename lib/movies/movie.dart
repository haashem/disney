class CategorizedMovie {
  final String title;
  final List<Movie> movies;

  CategorizedMovie({
    required this.title,
    required this.movies,
  });
}

class Movie {
  final String title;
  final String yearAndCategory;
  final String description;
  final String coverImageUrl;
  final String tileImageUrl;
  final String titleImageUrl;

  Movie({
    required this.title,
    required this.yearAndCategory,
    required this.description,
    required this.coverImageUrl,
    required this.tileImageUrl,
    required this.titleImageUrl,
  });
}

final List<CategorizedMovie> categories = [
  CategorizedMovie(title: 'Because You Watched', movies: [
    Movie(
        title: 'Primal Survivor',
        yearAndCategory: '2014 – 2020 • 5 Seasons • Reality, Docuserie',
        description:
            'Hazen Audel relives his most thrilling moments and reveals what it takes to become Primal Survivor.',
        coverImageUrl: 'assets/images/primal-survivor/cover.webp',
        tileImageUrl: 'assets/images/primal-survivor/tile.webp',
        titleImageUrl: 'assets/images/primal-survivor/title.webp'),
    Movie(
        title: 'A Goofy Movie',
        yearAndCategory: '1995 • 1h 23m • Action and Adventure, Comedy',
        description:
            'Goofy and Max hit the road and get up to their floppy ears in misadventure.',
        coverImageUrl: 'assets/images/goofy-movie/cover.webp',
        tileImageUrl: 'assets/images/goofy-movie/tile.webp',
        titleImageUrl: 'assets/images/goofy-movie/title.webp'),
    Movie(
        title: 'Primal Survivor',
        yearAndCategory: '2014 – 2020 • 5 Seasons • Reality, Docuserie',
        description:
            'Hazen Audel relives his most thrilling moments and reveals what it takes to become Primal Survivor.',
        coverImageUrl: 'assets/images/primal-survivor/cover.webp',
        tileImageUrl: 'assets/images/primal-survivor/tile.webp',
        titleImageUrl: 'assets/images/primal-survivor/title.webp'),
    Movie(
        title: 'Primal Survivor',
        yearAndCategory: '2014 – 2020 • 5 Seasons • Reality, Docuserie',
        description:
            'Hazen Audel relives his most thrilling moments and reveals what it takes to become Primal Survivor.',
        coverImageUrl: 'assets/images/primal-survivor/cover.webp',
        tileImageUrl: 'assets/images/primal-survivor/tile.webp',
        titleImageUrl: 'assets/images/primal-survivor/title.webp'),
    Movie(
        title: 'Running Wild with Bear Grylls',
        yearAndCategory:
            '2014 – 2021 • 2 Seasons • Action and Adventure, Reality',
        description:
            'Survivalist Bear Grylls takes celebrities on wild adventures they won’t forget.',
        coverImageUrl:
            'https://disney.images.edge.bamgrid.com/ripcut-delivery/v2/variant/disney/950b70e8-b278-4f79-b3ed-bed811b11b4b/compose?format=webp&width=2880',
        tileImageUrl:
            'https://disney.images.edge.bamgrid.com/ripcut-delivery/v2/variant/disney/ed52aad1-658e-4f2c-bf33-c742840a1dde/compose?format=webp&label=standard_art_178&width=800',
        titleImageUrl:
            'https://disney.images.edge.bamgrid.com/ripcut-delivery/v2/variant/disney/246426d2-47bf-4443-8b76-44f359186348/trim?format=webp&max=800%7C300')
  ]),
  CategorizedMovie(title: 'Animated Movies', movies: [
    Movie(
        title: 'Incredibles 2',
        yearAndCategory: '2018 • 1h 59m • Action and Adventure, Heroes',
        description:
            'The Incredibles spring into action when a dangerous new villain emerges.',
        coverImageUrl: 'assets/images/incredibles-2/cover.webp',
        tileImageUrl: 'assets/images/incredibles-2/tile.webp',
        titleImageUrl: 'assets/images/incredibles-2/title.webp'),
    Movie(
        title: 'A Goofy Movie',
        yearAndCategory: '1995 • 1h 23m • Action and Adventure, Comedy',
        description:
            'Goofy and Max hit the road and get up to their floppy ears in misadventure.',
        coverImageUrl: 'assets/images/goofy-movie/cover.webp',
        tileImageUrl: 'assets/images/goofy-movie/tile.webp',
        titleImageUrl: 'assets/images/goofy-movie/title.webp'),
    Movie(
        title: 'Tarzan',
        yearAndCategory: '1999 • 1h 37m • Action and Adventure, Coming of Age',
        description:
            'Adopted by gorillas, Tarzan’s life changes forever when he meets other humans.',
        coverImageUrl: 'assets/images/tarzan/cover.webp',
        tileImageUrl: 'assets/images/tarzan/tile.webp',
        titleImageUrl: 'assets/images/tarzan/title.webp'),
    Movie(
        title: 'Peter Pan & the Pirates',
        yearAndCategory: '1953 • 1h 22m • Action and Adventure, Animation',
        description:
            'Adventures await when Peter Pan and his friends fly to Never Land.',
        coverImageUrl: 'assets/images/peter-pan/cover.webp',
        tileImageUrl: 'assets/images/peter-pan/tile.webp',
        titleImageUrl: 'assets/images/peter-pan/title.webp'),
    Movie(
        title: 'Lion King',
        yearAndCategory: '1994 • 1h 34m • Action and Adventure, Coming of Age',
        description:
            """A cub who can't wait to be king finds his place in the "Circle of Life."""
            "",
        coverImageUrl:
            'assets/images/lion-king/cover.webp',
        tileImageUrl:
            'assets/images/lion-king/tile.webp',
        titleImageUrl:
            'assets/images/lion-king/title.webp')
  ])
];
