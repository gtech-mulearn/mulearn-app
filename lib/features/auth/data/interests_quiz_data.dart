import 'package:mulearn_app/features/auth/domain/entities/pathway.dart';

/// A single PathFinder quiz question — one option per [Pathway] category.
class QuizQuestion {
  const QuizQuestion({required this.question, required this.options});

  final String question;
  final List<QuizOption> options;
}

class QuizOption {
  const QuizOption({required this.text, required this.pathway});

  final String text;
  final Pathway pathway;
}

/// Approximate content — the reference dashboard's exact question wording
/// wasn't available to port verbatim (client-side-only copy, no API
/// contract), so this is original but equivalent in structure: 5 questions,
/// one option per [Pathway] category, tallied to the top 2 by count.
const List<QuizQuestion> kPathfinderQuizQuestions = [
  QuizQuestion(
    question: 'When starting a new project, what excites you most?',
    options: [
      QuizOption(text: 'Writing code to bring an idea to life', pathway: Pathway.coder),
      QuizOption(text: 'Building or prototyping something hands-on', pathway: Pathway.maker),
      QuizOption(text: 'Planning the roadmap and coordinating the team', pathway: Pathway.manager),
      QuizOption(text: 'Designing how it looks and feels', pathway: Pathway.creative),
    ],
  ),
  QuizQuestion(
    question: 'Pick a weekend activity:',
    options: [
      QuizOption(text: 'Debugging a tricky algorithm', pathway: Pathway.coder),
      QuizOption(text: 'Tinkering with hardware or electronics', pathway: Pathway.maker),
      QuizOption(text: 'Organizing a community meetup', pathway: Pathway.manager),
      QuizOption(text: 'Sketching, writing, or making art', pathway: Pathway.creative),
    ],
  ),
  QuizQuestion(
    question: 'Your ideal contribution to a team project:',
    options: [
      QuizOption(text: 'Writing clean, working code', pathway: Pathway.coder),
      QuizOption(text: 'Building the prototype or demo', pathway: Pathway.maker),
      QuizOption(text: 'Keeping everyone aligned and on schedule', pathway: Pathway.manager),
      QuizOption(text: 'Crafting the visual identity or story', pathway: Pathway.creative),
    ],
  ),
  QuizQuestion(
    question: 'Which skill do you want to sharpen most?',
    options: [
      QuizOption(text: 'Programming languages and frameworks', pathway: Pathway.coder),
      QuizOption(text: 'Hardware, robotics, or fabrication', pathway: Pathway.maker),
      QuizOption(text: 'Leadership and project management', pathway: Pathway.manager),
      QuizOption(text: 'Design, storytelling, or content creation', pathway: Pathway.creative),
    ],
  ),
  QuizQuestion(
    question: 'What kind of problem do you enjoy solving?',
    options: [
      QuizOption(text: 'Logical or technical puzzles', pathway: Pathway.coder),
      QuizOption(text: 'Physical or practical challenges', pathway: Pathway.maker),
      QuizOption(text: 'People and process challenges', pathway: Pathway.manager),
      QuizOption(text: 'Aesthetic or expressive challenges', pathway: Pathway.creative),
    ],
  ),
];
