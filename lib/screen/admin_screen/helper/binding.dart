import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/auth_add_question.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/auth_operation_admin.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_add_question_stage_three.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_delete_question.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_question_stage_two.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_update_question.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthOperationAdmin());
    Get.lazyPut(() => ViewQusetionStageTwo());
    Get.lazyPut(() => ViewAddQuestionStageThree());
    Get.lazyPut(() => AuthAddQuestion());
    Get.lazyPut(() => ViewDeleteQuestion());
    Get.lazyPut(() => ViewUpdateQuestion());
  }
}