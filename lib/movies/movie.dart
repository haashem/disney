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
  ])
];
