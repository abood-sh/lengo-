const String IMAGE_PATH_FOLDER = 'assets/images/';
const String IMAGE_PATH_FOLDER_ICON = '${ IMAGE_PATH_FOLDER }icons/';
const String AUDIO_PATH = "audio/";

class Assets {

  static final Assets shared = Assets();

  // TODO: Audio
  final String auCorrectAnswer = AUDIO_PATH + "au-correct-answer.mp3";
  final String auWrongAnswer = AUDIO_PATH + "au-wrong-answer.mp3";

  // TODO: Images
  final String bgStarts = IMAGE_PATH_FOLDER + "bg-starts.svg";

  // TODO: Icons
  final String icLogo = IMAGE_PATH_FOLDER_ICON + "ic-logo.svg";
  final String icStart = IMAGE_PATH_FOLDER_ICON + "ic-start.svg";
  final String icNote = IMAGE_PATH_FOLDER_ICON + "ic-note.svg";
  final String icEnglish = IMAGE_PATH_FOLDER_ICON + "ic-english.png";
  final String icEnglishSquare = IMAGE_PATH_FOLDER_ICON + "ic-english-square.png";
  final String icMale = IMAGE_PATH_FOLDER_ICON + "ic-male.svg";
  final String icFemale = IMAGE_PATH_FOLDER_ICON + "ic-female.svg";
  final String icHome = IMAGE_PATH_FOLDER_ICON + "ic-home.svg";
  final String icHomeFill = IMAGE_PATH_FOLDER_ICON + "ic-home-fill.svg";
  final String icRanking = IMAGE_PATH_FOLDER_ICON + "ic-ranking.svg";
  final String icRankingFill = IMAGE_PATH_FOLDER_ICON + "ic-ranking-fill.svg";
  final String icAccount = IMAGE_PATH_FOLDER_ICON + "ic-account.svg";
  final String icAccountFill = IMAGE_PATH_FOLDER_ICON + "ic-account-fill.svg";
  final String icCrown = IMAGE_PATH_FOLDER_ICON + "ic-crown.svg";
  final String icSpeaker = IMAGE_PATH_FOLDER_ICON + "ic-speaker.svg";

}