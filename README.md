## Project INT3306 - ExamReg - "TestReady"

```
ĐỀ BÀI

Trường đại học ABC (ABCUni) tổ chức thi kết thúc học phần bằng hình thức thi trắc nghiệm trên máy tính. Để tạo điều kiện tốt nhất cho thí sinh, ABCUni cho phép sinh viên tự đăng ký dự thi. Theo đó, ABCUni sẽ lập lịch cho các kỳ thi và ca thi trước, sinh viên đã học học phần nào sẽ được quyền đăng ký dự thi học phần đó tại ca thi phù hợp. Mỗi kỳ thi có nhiều ca thi. Mỗi ca thi có nhiều phòng thi. Mỗi phòng thi có số lượng máy tính xác định. Số lượng thí sinh có thể thi cùng ca thi bị giới hạn, không được vượt quá tổng số máy tính của các phòng thi trong ca thi. Khi ca thi đã đủ số lượng thí sinh đăng ký thì các thí sinh khác không thể đăng ký vào ca thi nữa.

Sinh viên đăng nhập vào phần mềm ExamReg mà ở đó đã có thông tin cá nhân sinh viên (do quản trị viên đưa vào CSDL trên cơ sở danh sách lớp học phần được các đơn vị đào tạo gửi) và CHỌN lịch thi của học phần sinh viên cần đăng ký dự thi. Trong lịch thi đó có thông tin điểm thi, các ca thi, các phòng thi của ca thi, số chỗ thi và có chức năng cho sinh viên chọn ca thi họ muốn dự thi. Sau khi sinh viên chọn xong thì lịch thi sinh viên đăng ký được xuất ra ở dạng báo cáo có tên gọi là PHIẾU BÁO DỰ THI và sinh viên download được/in được. Bản in, bản download đều có giá trị là minh chứng cho việc sinh viên đăng ký dự thi thành công. SV sử dụng phiếu báo dự thi này để đi thi.
```

- Công nghệ: Ruby on Rails 5.2.3

- Demo: https://testready-demo.herokuapp.com/

- Khung kiến trúc:

  1. ApplicationController
  2. DashboardController
  3. DashboardAdminController + DashboardStudentController

- Hướng dẫn cài đặt:

  - Sử dụng IDE RubyMine

  - ```
    bundle
    rails db:drop && rails db:create && rails db:migrate && rails db:seed
    ```

  - Mock-data có trong thư mục /ExamReg/MockData

  - Tài khoản mẫu:

    - Admin:

      ```
      megatunger@gmail.com
      1
      ```

    - Student: (studentID@abc.edu.vn - studentID)

      ```
      17021351@abc.edu.vn
      17021351
      ```

      

- Hình ảnh:

##### Đăng nhập

![Login](https://raw.githubusercontent.com/megatunger/testready/master/Images/Image-1.png)

##### Dashboard Admin

![DashboardAdmin](https://raw.githubusercontent.com/megatunger/testready/master/Images/Image-2.png)

##### Quản lí sinh viên

![StudentManagement](https://raw.githubusercontent.com/megatunger/testready/master/Images/Image-3.png)

##### Quản lí khoá học

![CourseManagement](https://raw.githubusercontent.com/megatunger/testready/master/Images/Image-4.png)

##### Quản lí phòng thi

![RoomManagement](https://raw.githubusercontent.com/megatunger/testready/master/Images/Image-5.png)

##### Quản lí lịch thi

![ScheduleManagement](https://raw.githubusercontent.com/megatunger/testready/master/Images/Image-6.png)

##### Đăng kí thi

![Register](https://raw.githubusercontent.com/megatunger/testready/master/Images/Image-7.png)

##### In phiếu báo dự thi

![Print](https://raw.githubusercontent.com/megatunger/testready/master/Images/Image-8.png)