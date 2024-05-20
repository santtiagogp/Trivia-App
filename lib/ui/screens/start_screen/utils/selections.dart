class Selections {
  static const List<String> difficulties = [
    'Easy', 'Medium', 'Hard'
  ];

  static const List<String> numberOfQuestions = [
    '3', '5', '10', '15', '20', '25', '30'
  ];

  static const List<String> categories = [
    'Any category',
    'General knowledge',
    'Entertaiment: Books',
    'Entertaiment: Film',
    'Entertaiment: Music',
    'Entertaiment: Musicals & Theatres',
    'Entertaiment: Television',
    'Entertaiment: Board games',
    'Science & Nature',
    'Science: Mathematics',
    'Mythology',
    'Sports',
    'Geography',
    'History',
    'Politics',
    'Art',
    'Celebrities',
    'Animals',
    'Vehicles',
    'Entertaiment: Comics',
    'Science: Gadgets',
    'Entertaiment: Japanese Anime & Manga',
    'Entertaiment: Cartoon & Animations'
  ];

  static const List<String> type = [
    'Any Type',
    'Multiple selection',
    'True or false'
  ];

  static const Map<String, dynamic> categoriesMap = {
    'Any category' : 8,
    'General knowledge' : 9,
    'Entertaiment: Books' : 10,
    'Entertaiment: Film' : 11,
    'Entertaiment: Music' : 12,
    'Entertaiment: Musicals & Theatres' : 13,
    'Entertaiment: Television' : 14,
    'Entertaiment: Video Games' : 15,
    'Entertaiment: Board games' : 16,
    'Science & Nature' : 17,
    'Science: Computers' : 18,
    'Science: Mathematics' : 19,
    'Mythology' : 20,
    'Sports' : 21,
    'Geography' : 22,
    'History' : 23,
    'Politics' : 24,
    'Art' : 25,
    'Celebrities' : 26,
    'Animals' : 27,
    'Vehicles' : 28,
    'Entertaiment: Comics' : 29,
    'Science: Gadgets' : 30,
    'Entertaiment: Japanese Anime & Manga' : 31,
    'Entertaiment: Cartoon & Animations' : 32
  };

  static const Map<String, dynamic> difficultyMap = {
    'Easy' : 'easy',
    'Medium' : 'medium',
    'Hard' : 'hard'
  };

  static const Map<String, dynamic> typeMap = {
    'Any Type' : '',
    'Multiple selection' : 'multiple',
    'True or false' : 'boolean'
  };
}