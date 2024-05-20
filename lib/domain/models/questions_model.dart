class Questions {
    final int responseCode;
    final List<Result> results;

    Questions({
        required this.responseCode,
        required this.results,
    });

}

class Result {
    final String type;
    final String difficulty;
    final String category;
    final String question;
    final String correctAnswer;
    final List<String> incorrectAnswers;

    Result({
        required this.type,
        required this.difficulty,
        required this.category,
        required this.question,
        required this.correctAnswer,
        required this.incorrectAnswers,
    });

}