import 'package:mulearn_app/features/auth/domain/entities/endgoal.dart';
import 'package:mulearn_app/features/auth/domain/entities/pathway.dart';

/// A single PathFinder quiz question — one option per [Pathway] category.
class QuizQuestion {
  const QuizQuestion({required this.question, required this.options});

  final String question;
  final List<QuizOption> options;
}

class QuizOption {
  const QuizOption({
    required this.text,
    required this.pathway,
    required this.highlight,
  });

  final String text;
  final Pathway pathway;

  /// The dashboard's one-line promise for the pathway.
  final String highlight;
}

const _makerLine = 'Build solutions that change the world';
const _coderLine = 'Create apps used by millions';
const _creativeLine = 'Design visuals that inspire millions';
const _managerLine = 'Lead teams to global success';

/// The dashboard's PathFinder questions, word for word
/// (`features/onboarding/data/questions.ts`, `pathfinderQuestions`).
const List<QuizQuestion> kPathfinderQuizQuestions = [
  QuizQuestion(
    question: 'What kind of activities do you enjoy the most?',
    options: [
      QuizOption(
        text:
            'Building or crafting physical projects and experimenting with new materials.',
        pathway: Pathway.maker,
        highlight: _makerLine,
      ),
      QuizOption(
        text:
            'Coding and creating software solutions or working with technology.',
        pathway: Pathway.coder,
        highlight: _coderLine,
      ),
      QuizOption(
        text:
            'Designing visual elements, user interfaces, or developing creative content.',
        pathway: Pathway.creative,
        highlight: _creativeLine,
      ),
      QuizOption(
        text:
            'Managing projects, understanding market needs, or exploring new knowledge areas.',
        pathway: Pathway.manager,
        highlight: _managerLine,
      ),
    ],
  ),
  QuizQuestion(
    question: 'Which skills do you want to develop?',
    options: [
      QuizOption(
        text: 'Robotics, 3D printing, or IoT-based projects.',
        pathway: Pathway.maker,
        highlight: _makerLine,
      ),
      QuizOption(
        text: 'Programming, debugging, or developing new applications.',
        pathway: Pathway.coder,
        highlight: _coderLine,
      ),
      QuizOption(
        text: 'Visual communication, UX/UI design, or multimedia creation.',
        pathway: Pathway.creative,
        highlight: _creativeLine,
      ),
      QuizOption(
        text: 'Leadership, marketing, research, or analysis skills.',
        pathway: Pathway.manager,
        highlight: _managerLine,
      ),
    ],
  ),
  QuizQuestion(
    question: 'How do you approach problem-solving?',
    options: [
      QuizOption(
        text: 'By physically experimenting, creating prototypes, and testing.',
        pathway: Pathway.maker,
        highlight: _makerLine,
      ),
      QuizOption(
        text:
            'By writing code, creating logical solutions, and troubleshooting.',
        pathway: Pathway.coder,
        highlight: _coderLine,
      ),
      QuizOption(
        text:
            'By brainstorming creative approaches and sketching visual solutions.',
        pathway: Pathway.creative,
        highlight: _creativeLine,
      ),
      QuizOption(
        text:
            'By analyzing holistically, researching, and planning strategically.',
        pathway: Pathway.manager,
        highlight: _managerLine,
      ),
    ],
  ),
  QuizQuestion(
    question: 'Which tools or resources interest you most?',
    options: [
      QuizOption(
        text: 'Electronic components, fabrication tools, robotics kits.',
        pathway: Pathway.maker,
        highlight: _makerLine,
      ),
      QuizOption(
        text: 'Programming languages, development frameworks, software tools.',
        pathway: Pathway.coder,
        highlight: _coderLine,
      ),
      QuizOption(
        text: 'Graphic design tools, wireframing software, creative suites.',
        pathway: Pathway.creative,
        highlight: _creativeLine,
      ),
      QuizOption(
        text: 'Business models, research papers, management tools.',
        pathway: Pathway.manager,
        highlight: _managerLine,
      ),
    ],
  ),
  QuizQuestion(
    question: 'What kind of project excites you the most?',
    options: [
      QuizOption(
        text: 'Creating a new physical device or automated system.',
        pathway: Pathway.maker,
        highlight: _makerLine,
      ),
      QuizOption(
        text: 'Developing an app or building a machine learning model.',
        pathway: Pathway.coder,
        highlight: _coderLine,
      ),
      QuizOption(
        text: "Designing a logo or improving a website's user experience.",
        pathway: Pathway.creative,
        highlight: _creativeLine,
      ),
      QuizOption(
        text: 'Organizing an event or developing a new business idea.',
        pathway: Pathway.manager,
        highlight: _managerLine,
      ),
    ],
  ),
];

/// The dashboard's `pathwayInfo`: each pathway's title and what it covers
/// (the results screen shows the first three).
const Map<Pathway, ({String title, List<String> includes})> kPathwayInfo = {
  Pathway.coder: (
    title: 'Coder',
    includes: [
      'Programming Languages',
      'Web Development',
      'Mobile App Development',
      'Software Engineering',
      'Database Management',
      'Cloud Computing',
      'DevOps & CI/CD',
      'System Architecture',
    ],
  ),
  Pathway.maker: (
    title: 'Maker',
    includes: [
      'Hardware Design',
      'Electronics',
      '3D Printing',
      'Robotics',
      'IoT Development',
      'Prototyping',
      'CAD/CAM',
      'Product Design',
    ],
  ),
  Pathway.manager: (
    title: 'Manager',
    includes: [
      'Project Management',
      'Team Leadership',
      'Business Strategy',
      'Resource Planning',
      'Risk Management',
      'Agile Methodologies',
      'Stakeholder Management',
      'Process Optimization',
    ],
  ),
  Pathway.creative: (
    title: 'Creative',
    includes: [
      'UI/UX Design',
      'Graphic Design',
      'Digital Marketing',
      'Content Creation',
      'Brand Strategy',
      'Animation',
      'Video Production',
      'Social Media Management',
    ],
  ),
};

/// The dashboard's `endgoalOptions` titles.
String endgoalTitle(Endgoal e) => switch (e) {
  Endgoal.job => 'Job',
  Endgoal.researchAndDevelopment => 'Research & Development',
  Endgoal.entrepreneurship => 'Entrepreneurship',
  Endgoal.gigWork => 'Gig Work',
  Endgoal.higherEducation => 'Higher Education',
  Endgoal.socialImpact => 'Social Impact',
};

/// The dashboard's `getRecommendedPathways`: count each pathway's answers
/// and take the top two, always two. Ties keep the order coder, maker,
/// manager, creative (a stable sort over that order).
List<Pathway> recommendPathways(List<Pathway> answers) {
  const order = [
    Pathway.coder,
    Pathway.maker,
    Pathway.manager,
    Pathway.creative,
  ];
  final counts = {for (final p in order) p: 0};
  for (final a in answers) {
    counts[a] = counts[a]! + 1;
  }
  // List.sort isn't stable, so ties are broken by the order explicitly.
  return ([...order]..sort((a, b) {
        final byCount = counts[b]!.compareTo(counts[a]!);
        return byCount != 0 ? byCount : order.indexOf(a) - order.indexOf(b);
      }))
      .take(2)
      .toList();
}
