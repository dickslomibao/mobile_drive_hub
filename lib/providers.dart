import 'package:mobile_drive_hub/controllers/auth/login_contoller.dart';
import 'package:mobile_drive_hub/controllers/email_verification_controller.dart';
import 'package:mobile_drive_hub/controllers/instructor/view_student_progress.dart';
import 'package:mobile_drive_hub/controllers/student/profile_screen_controller.dart';
import 'package:mobile_drive_hub/controllers/student/schedules/schedule_view_screen.dart';
import 'package:mobile_drive_hub/controllers/student/search/filter_courses_controller.dart';
import 'package:mobile_drive_hub/controllers/student/search/filter_driving_school_controller.dart';
import 'package:mobile_drive_hub/controllers/instructor/instructor_start_practical_controller.dart';
import 'package:mobile_drive_hub/controllers/student/course/mock_quiz_controller.dart';
import 'package:mobile_drive_hub/controllers/student/course/mock_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:mobile_drive_hub/controllers/student/order/order_controller.dart';
import 'package:mobile_drive_hub/controllers/message/messages_controller.dart';
import 'package:provider/single_child_widget.dart';
import 'controllers/auth/register_controller.dart';
import 'controllers/instructor/instructor_profile_controller.dart';
import 'controllers/message/conversation_controller.dart';
import 'controllers/school/school_course_view_controller.dart';
import 'controllers/student/course/courses_controller.dart';
import 'controllers/instructor/instructor_schedules_controller.dart';
import 'controllers/instructor/view_schedules_controller.dart';
import 'controllers/school/promo_controller.dart';
import 'controllers/student/course/view_mycourses_controller.dart';
import 'controllers/student/schedules/schedules_controller.dart';
import 'controllers/student_controller.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => LoginController(),
  ),
  ChangeNotifierProvider(
    create: (context) => RegisterController(),
  ),
  ChangeNotifierProvider(
    create: (context) => ConversationController(),
  ),
  ChangeNotifierProvider(
    create: (context) => MessagesController(),
  ),
  ChangeNotifierProvider(
    create: (context) => StudentController(),
  ),
  ChangeNotifierProvider(
    create: (context) => OrderController(),
  ),
  ChangeNotifierProvider(
    create: (context) => SchoolCourseViewController(),
  ),
  ChangeNotifierProvider(
    create: (context) => InstructorViewSchedulesController(),
  ),
  ChangeNotifierProvider(
    create: (context) => CoursesController(),
  ),
  ChangeNotifierProvider(
    create: (context) => ViewMyCoursesController(),
  ),
  ChangeNotifierProvider(
    create: (context) => StudentSchedulesController(),
  ),
  ChangeNotifierProvider(
    create: (context) => InstructorScheduleController(),
  ),
  ChangeNotifierProvider(
    create: (context) => InstructorStartSchedulesController(),
  ),
  ChangeNotifierProvider(
    create: (context) => PromoController(),
  ),
  ChangeNotifierProvider(
    create: (context) => FilterCoursesController(),
  ),
  ChangeNotifierProvider(
    create: (context) => FilterDrivingSchoolController(),
  ),
  ChangeNotifierProvider(
    create: (context) => GetMockListController(),
  ),
  ChangeNotifierProvider(
    create: (context) => MockQuizController(),
  ),
  ChangeNotifierProvider(
    create: (context) => EmailVerificationController(),
  ),
  ChangeNotifierProvider(
    create: (context) => StudentViewSchedulesController(),
  ),
  ChangeNotifierProvider(
    create: (context) => ViewStudentProgress(),
  ),
  ChangeNotifierProvider(
    create: (context) => StudentProfileController(),
  ),
  ChangeNotifierProvider(
    create: (context) => InstructorProfileController(),
  ),
];
