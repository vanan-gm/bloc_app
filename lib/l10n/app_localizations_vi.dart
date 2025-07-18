// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get signIn => 'Đăng Nhập';

  @override
  String get dontHaveAnAccount => 'Chưa có tài khoản';

  @override
  String get createAccountSuccessfully => 'Tạo tài khoản thành công';

  @override
  String get signUp => 'Đăng Ký';

  @override
  String get name => 'Tên';

  @override
  String get password => 'Mật khẩu';

  @override
  String get passwordConfirm => 'Xác nhận mật khẩu';

  @override
  String get alreadyHaveAnAccount => 'Đã có tài khoản';

  @override
  String get invalidEmail => 'Email không hợp lệ';

  @override
  String get invalidPassword => 'Mật khẩu không hợp lệ';

  @override
  String get invalidName => 'Tên không hợp lệ';

  @override
  String get passwordConfirmDoesNotMatch => 'Xác nhận mật khẩu chưa trùng';

  @override
  String get home => 'Trang chủ';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get favorite => 'Yêu thích';

  @override
  String get myFavoriteBlogs => 'Blogs yêu thích của tôi';

  @override
  String get settings => 'Cài đặt';

  @override
  String get mins => 'phút';

  @override
  String get searchBlogsHere => 'Tìm blogs ở đây...';

  @override
  String get account => 'Tài Khoản';

  @override
  String get profile => 'Hồ Sơ';

  @override
  String get editProfile => 'Chỉnh Sửa Thông Tin';

  @override
  String get followers => 'Theo Dõi';

  @override
  String get posts => 'Bài Đăng';

  @override
  String get likes => 'Thích';

  @override
  String get views => 'Lượt Xem';

  @override
  String get updates => 'Cập Nhật';

  @override
  String get pictures => 'Hình Ảnh';

  @override
  String get about => 'Giới Thiệu';

  @override
  String aboutDescription1(String name) {
    return 'Xin chào, tôi là $name, một người đam mê du lịch, kể chuyện và viết blog với niềm tò mò vô tận về việc khám phá thế giới. Du lịch không chỉ là sở thích của tôi — đó là cách sống. Từ việc dạo bước trên những con phố cổ đầy lịch sử đến thư giãn trên những bãi biển hoang sơ, mỗi chuyến đi đều nuôi dưỡng khát khao khám phá và chia sẻ của tôi.';
  }

  @override
  String get aboutDescription2 =>
      'Thông qua blog của mình, tôi mang những trải nghiệm đến với cuộc sống bằng những câu chuyện sống động, nhiếp ảnh tuyệt đẹp và các mẹo du lịch thiết thực. Tôi yêu việc khám phá những viên ngọc ẩn, đắm mình trong các nền văn hóa đa dạng và ghi lại tinh hoa của mỗi nơi tôi đặt chân đến. Dù là những chuyến phiêu lưu một mình, hành trình khám phá văn hóa, trải nghiệm ẩm thực hay những chuyến đi qua các cảnh quan ngoạn mục, tôi tin rằng mỗi chuyến đi đều có một câu chuyện đáng để kể.';

  @override
  String get changePassword => 'Thay Đổi Mật Khẩu';

  @override
  String get newPassword => 'Mật khẩu mới';

  @override
  String get confirmPassword => 'Mật khẩu xác nhận';

  @override
  String get changePasswordDescription1 =>
      'Mật khẩu mới của bạn phải khác với mật khẩu trước đó';

  @override
  String get changePasswordDescription2 =>
      'Mật khẩu mới phải tuân thủ chính sách mật khẩu.';

  @override
  String get changePasswordDescription3 => 'Mật khẩu phải có ít nhất 08 ký tự.';

  @override
  String get changePasswordDescription4 =>
      'Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt, ví dụ như @, &, %, ™, ...';

  @override
  String get changePasswordDescription5 =>
      'Mật khẩu phải chứa ít nhất 3 loại ký tự khác nhau, chẳng hạn như chữ hoa, chữ thường, chữ số và dấu câu.';

  @override
  String get confirmChange => 'Xác Nhận';

  @override
  String get failedToChangePassword => 'Đổi mật khẩu không thành công';

  @override
  String get changePasswordSuccessMessage => 'Đổi mật khẩu thành công';

  @override
  String get preference => 'Tùy Chọn';

  @override
  String get language => 'Ngôn Ngữ';

  @override
  String get lightMode => 'Chế Độ Ban Ngày';

  @override
  String get enableFingerPrint => 'Kích Hoạt Vân Tay';

  @override
  String get aboutApp => 'Giới Thiệu Ứng Dụng';

  @override
  String get rateUs => 'Đánh Giá';

  @override
  String get logout => 'Đăng Xuất';

  @override
  String get logoutOfYourAccount => 'Đăng Xuất Tài Khoản';

  @override
  String get logoutWarning =>
      'Đăng xuất sẽ tạm thời ẩn tất cả các bài blog. Để xem lại, hãy đăng nhập lại vào tài khoản của bạn.';

  @override
  String get signOutSuccessMessage => 'Đăng xuất thành công';

  @override
  String get encounterError => 'Đã xảy ra lỗi!!';

  @override
  String get notification => 'Thông Báo';

  @override
  String get featureInProgressMessage =>
      'Tính năng này đang được phát triển, vui lòng quay lại sau.';

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Hủy';

  @override
  String get version => 'Phiên Bản';

  @override
  String get by => 'Viết bởi';

  @override
  String get selectYourImage => 'Chọn ảnh của bạn';

  @override
  String get technology => 'Công Nghệ';

  @override
  String get business => 'Kinh Doanh';

  @override
  String get programming => 'Lập Trình';

  @override
  String get entertainment => 'Giải Trí';

  @override
  String get planetary => 'Hành Tinh';

  @override
  String get music => 'Âm Nhạc';

  @override
  String get travelling => 'Du Lịch';

  @override
  String get nature => 'Thiên Nhiên';

  @override
  String get communication => 'Giao Tiếp';

  @override
  String get education => 'Giáo Dục';

  @override
  String get science => 'Khoa Học';

  @override
  String get social => 'Xã Hội';

  @override
  String get health => 'Sức Khỏe';

  @override
  String get selfImprovement => 'Cải Thiện Bản Thân';

  @override
  String get history => 'Lịch Sử';

  @override
  String get cultureAndTraditions => 'Văn Hóa & Truyền Thống';

  @override
  String get gaming => 'Trò Chơi';

  @override
  String get photography => 'Nhiếp Ảnh';

  @override
  String get moviesAndTvShows => 'Phim & Truyền Hình';

  @override
  String get spaceAndAstronomy => 'Không gian & Thiên văn học';

  @override
  String get aiAndMachineLearning => 'Trí tuệ nhân tạo & Học máy';

  @override
  String get blogTitle => 'Tiêu đề blog';

  @override
  String get blogContent => 'Nội dung blog';

  @override
  String get failedToUploadBlog => 'Upload blog thất bại';

  @override
  String get fieldMustBeNonEmpty => 'Field không được để trống';

  @override
  String get fieldMustBeOver6Char => 'Field phải có hơn 6 ký tự';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

  @override
  String get english => 'Tiếng Anh';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get aboutAppSlogan => 'Tự do kể chuyện, tự do sẻ chia';

  @override
  String get build => 'Bản dựng';

  @override
  String get size => 'Kích thước';

  @override
  String get platform => 'Nền tảng';

  @override
  String get minOsVersion => 'HĐH tối thiểu';

  @override
  String get license => 'Bản quyền';

  @override
  String get designedBy => 'Thiết kế';

  @override
  String get footerContent => '© 2025 BlogApp. Đã đăng ký bản quyền.';
}
