enum UserType {
  student,
  school,
  instructor,
}

UserType toTypeEnum(int value) {
  switch (value) {
    case 1:
      return UserType.school;
    case 2:
      return UserType.instructor;
    case 3:
      return UserType.student;
    default:
      throw ArgumentError('Invalid value: $value');
  }
}

int toTypeInt(UserType userType) {
  switch (userType) {
    case UserType.school:
      return 1;
    case UserType.instructor:
      return 2;
    case UserType.student:
      return 3;
  }
}
