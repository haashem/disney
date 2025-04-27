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

final featuredMovies = CategorizedMovie(title: 'Featured', movies: [
  Movie(
      title: 'Star Wars',
      yearAndCategory: '',
      description: '',
      coverImageUrl: 'assets/images/star-wars/cover.webp',
      tileImageUrl: 'assets/images/star-wars/tile.webp',
      titleImageUrl: 'assets/images/star-wars/title.webp'),
  Movie(
    title: 'Tracker',
    yearAndCategory: '',
    description: '',
    coverImageUrl: 'assets/images/tracker/cover.webp',
    tileImageUrl: 'assets/images/tracker/tile.webp',
    titleImageUrl: 'assets/images/tracker/title.webp',
  ),
  Movie(
      title: 'Dare Devil',
      yearAndCategory: '',
      description: '',
      coverImageUrl: 'assets/images/daredevil/cover.webp',
      tileImageUrl: 'assets/images/daredevil/tile.webp',
      titleImageUrl: 'assets/images/daredevil/title.webp'),
  Movie(
      title: 'Andior',
      yearAndCategory: '',
      description: '',
      coverImageUrl: 'assets/images/andior/cover.webp',
      tileImageUrl: 'assets/images/andior/tile.webp',
      titleImageUrl: 'assets/images/andior/title.webp'),
  Movie(
      title: 'A Complete Unknown',
      yearAndCategory: '',
      description: '',
      coverImageUrl: 'assets/images/a-complete-unknown/cover.webp',
      tileImageUrl: 'assets/images/a-complete-unknown/tile.webp',
      titleImageUrl: 'assets/images/a-complete-unknown/title.webp'),
]);

final List<CategorizedMovie> categories = [
  CategorizedMovie(title: 'Actions', movies: [
    Movie(
      title: 'Haunted Mansion',
      yearAndCategory: '2023 • 2h 2m • Action and Adventure, Comedy',
      description:
          'A mother and son enlist a motley crew of so-called spiritual experts to help rid their home of supernatural squatters.',
      coverImageUrl: 'assets/images/haunted-mansion/cover.webp',
      tileImageUrl: 'assets/images/haunted-mansion/tile.webp',
      titleImageUrl: 'assets/images/haunted-mansion/title.webp',
    ),
    Movie(
        title: 'Pirates of the Caribbean',
        yearAndCategory: '2003 • 2h 23m • Action and Adventure, Fantasy',
        description:
            'A blacksmith teams up with a pirate to rescue his kidnapped love from a ship of ghostly pirates.',
        coverImageUrl: 'assets/images/pirates-of-the-caribbean/cover.webp',
        tileImageUrl: 'assets/images/pirates-of-the-caribbean/tile.webp',
        titleImageUrl: 'assets/images/pirates-of-the-caribbean/title.webp'),
    Movie(
        title: 'Avatar',
        yearAndCategory: '2009 • 2h 42m • Action and Adventure, Sci-Fi',
        description:
            'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting a world he feels is his home.',
        coverImageUrl: 'assets/images/avatar/cover.webp',
        tileImageUrl: 'assets/images/avatar/tile.webp',
        titleImageUrl: 'assets/images/avatar/title.webp'),
    Movie(
        title: 'Davy Crockett: King of the Wild Frontier',
        yearAndCategory: '1955 • 1h 33m • Action and Adventure, Western',
        description:
            'Davy Crockett, a backwoodsman, fights to save the Alamo from Santa Anna.',
        coverImageUrl: 'assets/images/davy-crocket/cover.webp',
        tileImageUrl: 'assets/images/davy-crocket/tile.webp',
        titleImageUrl: 'assets/images/davy-crocket/title.webp'),
    Movie(
        title: 'Knight and Day',
        yearAndCategory: '2010 • 1h 39m • Action and Adventure, Comedy',
        description:
            'Tom Cruise and Cameron Diaz dazzle as action and comedy collide in this Extended Edition.',
        coverImageUrl: 'assets/images/knight-and-day/cover.webp',
        tileImageUrl: 'assets/images/knight-and-day/tile.webp',
        titleImageUrl: 'assets/images/knight-and-day/title.webp'),
  ]),
  CategorizedMovie(title: 'Recommended For You', movies: [
    Movie(
        title: 'Ice Age: The Meltdown',
        yearAndCategory: '',
        description: '',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/ice-age-buck-wild/tile.jpg',
        titleImageUrl: ''),
    Movie(
      title: 'Ice Age',
      yearAndCategory: '',
      description: '',
      coverImageUrl: '',
      tileImageUrl: 'assets/images/ice-age/tile.jpg',
      titleImageUrl: '',
    ),
    Movie(
      title: 'Hercules',
      yearAndCategory: '',
      description: '',
      coverImageUrl: '',
      tileImageUrl: 'assets/images/hercules/tile.jpg',
      titleImageUrl: '',
    ),
    Movie(
      title: 'Robin Hood',
      yearAndCategory: '',
      description: '',
      coverImageUrl: '',
      tileImageUrl: 'assets/images/robin-hood/tile.jpg',
      titleImageUrl: '',
    ),
    Movie(
      title: '101 Dalmatians',
      yearAndCategory: '',
      description: '',
      coverImageUrl: '',
      tileImageUrl: 'assets/images/101/tile.jpg',
      titleImageUrl: '',
    ),
  ]),
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
        title: 'Shogun',
        yearAndCategory: '2024 • 1 Season • Drama, Action and Adventure',
        description:
            'Lord Toranaga is fighting for his life when a mysterious ship is marooned in a nearby village.',
        coverImageUrl: 'assets/images/shogun/cover.webp',
        tileImageUrl: 'assets/images/shogun/tile.webp',
        titleImageUrl: 'assets/images/shogun/title.webp'),
  ]),
  CategorizedMovie(title: 'Documentaries', movies: [
    Movie(
        title: 'Aliens of the Deep',
        yearAndCategory: '2005 • 1h 22m • Documentary, Nature',
        description:
            'James Cameron and a team of scientists explore the ocean’s depths to discover new life forms.',
        coverImageUrl: 'assets/images/aliens-of-the-deep/cover.webp',
        tileImageUrl: 'assets/images/aliens-of-the-deep/tile.webp',
        titleImageUrl: 'assets/images/aliens-of-the-deep/title.webp'),
    Movie(
        title: 'Hostile Planet',
        yearAndCategory: '2019 • 1 Season • Documentary, Nature',
        description:
            'This series takes a look at the most extreme environments on Earth and the animals that live there.',
        coverImageUrl: 'assets/images/hostile-planet/cover.webp',
        tileImageUrl: 'assets/images/hostile-planet/tile.webp',
        titleImageUrl: 'assets/images/hostile-planet/title.webp'),
    Movie(
        title: 'Atlantis Rising',
        yearAndCategory: '2017 • 1h 35m • Documentaries, History',
        description:
            "Filmmakers go in search of Atlantis using Plato's writings as a guide to lead the way.",
        coverImageUrl: 'assets/images/atlantis-rising/cover.webp',
        tileImageUrl: 'assets/images/atlantis-rising/tile.webp',
        titleImageUrl: 'assets/images/atlantis-rising/title.webp'),
    Movie(
        title: 'Drain the Ocean',
        yearAndCategory: '2018 • 1h 24m • Documentary, Nature',
        description:
            'Using CGI, scientists drain the ocean to reveal shipwrecks and lost cities.',
        coverImageUrl: 'assets/images/drain-the-oceans/cover.webp',
        tileImageUrl: 'assets/images/drain-the-oceans/tile.webp',
        titleImageUrl: 'assets/images/drain-the-oceans/title.webp'),
    Movie(
        title: 'Wild Yellowstone',
        yearAndCategory: '2015 • Documentary, Nature',
        description:
            'The world’s first national park is home to a variety of wildlife, including wolves, bears, and bison.',
        coverImageUrl: 'assets/images/wild-yellowstone/cover.webp',
        tileImageUrl: 'assets/images/wild-yellowstone/tile.webp',
        titleImageUrl: 'assets/images/wild-yellowstone/title.webp'),
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
        coverImageUrl: 'assets/images/lion-king/cover.webp',
        tileImageUrl: 'assets/images/lion-king/tile.webp',
        titleImageUrl: 'assets/images/lion-king/title.webp')
  ])
];

final List<List<Movie>> seasons = [
  [
    Movie(
        title: '1. Chapter 1: The Mandalorian',
        yearAndCategory: '',
        description:
            'A Mandalorian bounty hunter tracks a target for a well-paying, mysterious client.',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/star-wars/season1/tile1.webp',
        titleImageUrl: ''),
    Movie(
        title: '2. Chapter 2: The Child',
        yearAndCategory: '',
        description:
            'Having tracked down a valuable quarry, the Mandalorian must now contend with thieving bandits.',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/star-wars/season1/tile2.webp',
        titleImageUrl: ''),
    Movie(
        title: '3. Chapter 3: The Sin',
        yearAndCategory: '',
        description:
            'The battered Mandalorian returns to his client for reward, but some deals don’t end neatly.',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/star-wars/season1/tile3.webp',
        titleImageUrl: '')
  ],
  [
    Movie(
        title: '1. Chapter 9: The Marshal',
        yearAndCategory: '',
        description:
            'The Mandalorian is drawn to the Outer Rim in search of others of his kind.',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/star-wars/season2/tile1.webp',
        titleImageUrl: ''),
    Movie(
        title: '2. Chapter 10: The Passenger',
        yearAndCategory: '',
        description:
            'The Mandalorian must ferry a passenger with precious cargo on a risky journey.',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/star-wars/season2/tile2.webp',
        titleImageUrl: ''),
    Movie(
        title: '3. Chapter 11: The Heiress',
        yearAndCategory: '',
        description:
            'The Mandalorian braves high seas and meets unexpected allies.',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/star-wars/season2/tile3.webp',
        titleImageUrl: '')
  ],
  [
    Movie(
        title: '1. Chapter 17: The Apostate',
        yearAndCategory: '',
        description: 'The Mandalorian begins an important journey.',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/star-wars/season3/tile2.webp',
        titleImageUrl: ''),
    Movie(
        title: '2. Chapter 18: The Mines of Mandalore',
        yearAndCategory: '',
        description:
            'The Mandalorian and Grogu explore the ruins of a destroyed planet.',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/star-wars/season3/tile1.webp',
        titleImageUrl: ''),
    
    Movie(
        title: '3. Chapter 19: The Convert',
        yearAndCategory: '',
        description:
            'On Coruscant, former Imperials find amnesty in the New Republic.',
        coverImageUrl: '',
        tileImageUrl: 'assets/images/star-wars/season3/tile3.webp',
        titleImageUrl: '')
  ]
];
