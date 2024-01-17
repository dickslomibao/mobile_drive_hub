String courseStatus(int status) {
  switch (status) {
    case 1:
      return 'Waiting for payment';
    case 2:
      return 'Processing Schedule';
    case 3:
      return 'Ongoing';
    default:
      return '';
  }
}

String orderStatus(int status) {
  switch (status) {
    case 1:
      return 'Pending Order';
    case 2:
      return 'To pay';
    case 3:
      return 'Waiting for requirements';
    case 4:
      return 'Courses ongoing';
    case 5:
      return 'Order Completed';
    case 6:
      return 'Cancelled';
    case 7:
      return 'Refunded';
    default:
      return '';
  }
}

String sessionStatus(int status) {
  switch (status) {
    case 1:
      return 'Waiting';
    case 2:
      return 'Started Already';
    case 3:
      return 'Completed';
    case 4:
      return 'Canceled';
    default:
      return '';
  }
}

String paymentType(int status) {
  switch (status) {
    case 1:
      return 'Cash';
    case 2:
      return 'Gcash';
    case 3:
      return 'Credit Card';
    default:
      return '';
  }
}

Map<String, dynamic> myCourseStatus(int status) {
  switch (status) {
    case 1:
      return {'status': 'Course Ongoing'};
    case 2:
      return {'status': 'Course Ongoing'};
    default:
      return {'status': 'Waiting for session'};
  }
}
