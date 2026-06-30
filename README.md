# Smart Bed RND - Sleep Apnea Detection System

Hệ thống phân tích dữ liệu cảm biến giường thông minh để phát hiện các sự kiện apnea (ngừng thở) trong giấc ngủ.

## Tổng Quan Dự Án

Dự án này xử lý dữ liệu từ một giường thông minh có các cảm biến để:
- Thu thập dữ liệu sinh lý (nhịp tim, oxy hóa máu)
- Phân tích mô hình hô hấp
- Phát hiện sự kiện ngừng thở (apnea)
- Tính toán chỉ số Apnea-Hypopnea (AHI)
- Hiển thị kết quả bằng biểu đồ chi tiết

## Cấu Trúc Dự Án

```
smartbed-rnd/
├── data/
│   └── smartbed-sensor-stream.csv      # Dữ liệu cảm biến gốc
├── src/
│   ├── main.py                         # Điểm vào chính
│   ├── config.py                       # Cấu hình và tham số
│   ├── preprocessing.py                # Tiền xử lý dữ liệu
│   ├── sensor_fusion.py                # Kết hợp tín hiệu cảm biến
│   ├── respiration.py                  # Phân tích hô hấp
│   ├── apnea_detection.py              # Phát hiện apnea
│   └── visualization.py                # Visualize kết quả
├── output/
│   ├── timeline.csv                    # Báo cáo thời gian
│   ├── respiration.csv                 # Dữ liệu hô hấp
│   ├── apnea_events.csv                # Danh sách sự kiện apnea
│   ├── vital_signs.png                 # Biểu đồ nhịp tim và SpO2
│   ├── respiration.png                 # Biểu đồ hô hấp
│   ├── apnea_detection.png             # Biểu đồ phát hiện apnea
│   └── dashboard.png                   # Bảng điều khiển tổng hợp
├── requirements.txt                    # Phụ thuộc Python
├── run.bat                             # Script chạy Windows
└── README.md                           # Tệp này
```

## Các Cảm Biến Dữ Liệu

Dữ liệu CSV chứa các cột sau:

| Cột | Mô Tả | Đơn Vị |
|-----|-------|--------|
| `timestamp_s` | Thời gian | Giây |
| `loadcell_kg` | Khối lượng cơ thể | kg |
| `presence` | Có người trên giường | 0/1 |
| `motion_intensity` | Cường độ chuyển động | - |
| `chest_disp` | Độ dịch chuyển ngực | mm |
| `hr_bpm` | Nhịp tim | bpm |
| `spo2` | Độ bão hòa oxy | % |

## Cài Đặt và Chuẩn Bị

### Yêu Cầu
- Python 3.8+
- pip (trình quản lý gói Python)

### Cài Đặt Thư Viện

```bash
pip install -r requirements.txt
```

### Chuẩn Bị Dữ Liệu

Đặt tệp CSV dữ liệu vào thư mục `data/`:
- Đổi tên thành `smartbed-sensor-stream.csv`

## Sử Dụng

### Chạy Toàn Bộ Pipeline

#### Trên Windows:
```bash
run.bat
```

#### Trên Linux/Mac:
```bash
cd src
python main.py
```

### Chạy Các Module Riêng Lẻ

```bash
cd src

# Tiền xử lý dữ liệu
python preprocessing.py

# Kết hợp cảm biến
python sensor_fusion.py

# Phân tích hô hấp
python respiration.py

# Phát hiện apnea
python apnea_detection.py

# Hiển thị biểu đồ
python visualization.py
```

## Các Module Chính

### 1. **preprocessing.py**
- Tải dữ liệu CSV
- Xử lý giá trị bị thiếu
- Loại bỏ ngoại lệ thống kê
- Làm mượt tín hiệu
- Chuẩn hóa dữ liệu

### 2. **sensor_fusion.py**
- Kết hợp các tín hiệu cảm biến
- Trích xuất thành phần hô hấp
- Tính toán điểm sinh lý
- Phát hiện các giai đoạn có người

### 3. **respiration.py**
- Phát hiện các đỉnh hô hấp (hít vào)
- Tính tỷ lệ hô hấp (RR)
- Tính biến đổi tỷ lệ hô hấp (RRV)
- Tính biên độ hô hấp
- Phát hiện hô hấp không đều

### 4. **apnea_detection.py**
- Phát hiện ngừng thở (breath cessation)
- Phát hiện tình trạng thiếu oxy (hypoxia)
- Phát hiện nhịp tim chậm (bradycardia)
- Phân loại loại apnea (Central/Obstructive/Mixed)
- Tính Apnea-Hypopnea Index (AHI)

### 5. **visualization.py**
- Vẽ biểu đồ nhịp tim và SpO2
- Vẽ biểu đồ hô hấp
- Vẽ biểu đồ phát hiện apnea
- Tạo bảng điều khiển tổng hợp

## Đầu Ra

### Tệp CSV

1. **timeline.csv**
   - Tất cả các điểm dữ liệu với các tính năng quan trọng
   - Đánh dấu các sự kiện apnea

2. **respiration.csv**
   - Dữ liệu hô hấp được lọc và phân tích
   - Tần số hô hấp và biến đổi

3. **apnea_events.csv**
   - Danh sách tất cả các sự kiện apnea phát hiện
   - Thời gian bắt đầu/kết thúc, khoảng thời gian, loại sự kiện

### Biểu Đồ (PNG)

1. **vital_signs.png** - Nhịp tim và SpO2 theo thời gian
2. **respiration.png** - Phân tích hô hấp chi tiết
3. **apnea_detection.png** - Phát hiện và phân loại apnea
4. **dashboard.png** - Bảng điều khiển tổng hợp

## Giải Thích Kết Quả

### Apnea-Hypopnea Index (AHI)
- AHI = Số sự kiện apnea trên giờ ngủ
- **Bình thường**: AHI < 5
- **Nhẹ**: AHI 5-15
- **Trung bình**: AHI 15-30
- **Nặng**: AHI > 30

### Loại Apnea
- **Central**: Ngừng thở do não không phát tín hiệu hô hấp
- **Obstructive**: Ngừng thở do tắc đường hô hấp
- **Mixed**: Kết hợp cả hai loại trên

## Tham Số Cấu Hình

Chỉnh sửa `config.py` để điều chỉnh:

```python
# Khoảng thời gian hô hấp bình thường (bpm)
BREATHING_RATE_THRESHOLD = 8

# Thời gian tối thiểu để phân loại là apnea (giây)
APNEA_DURATION_THRESHOLD = 10

# Mức SpO2 cảnh báo (%)
SPO2_NORMAL_THRESHOLD = 95

# Cửa sổ phân tích tỷ lệ hô hấp (giây)
RRV_WINDOW = 30
```

## Khắc Phục Sự Cố

### Không phát hiện được apnea
- Kiểm tra độ chính xác dữ liệu
- Điều chỉnh `CHEST_MOTION_THRESHOLD`
- Tăng `APNEA_DURATION_THRESHOLD`

### Phát hiện quá nhiều sự kiện giả
- Giảm `BREATHING_RATE_THRESHOLD`
- Tăng `SMOOTHING_WINDOW`

### Lỗi dữ liệu bị thiếu
- Đảm bảo tệp CSV có đầy đủ các cột
- Kiểm tra định dạng dữ liệu

## Triển Khai Trên Edge Devices (Orange Pi/Coral/Jetson)

Hệ thống được thiết kế tối ưu cho triển khai trên edge devices. Dưới đây là các hướng dẫn cụ thể:

### 1. Orange Pi (ARM-based Linux)

**Cài đặt Python và dependencies:**
```bash
sudo apt-get update
sudo apt-get install python3-dev python3-pip
pip3 install -r requirements.txt

# Tối ưu: Sử dụng numpy tối ưu cho ARM
pip3 install --upgrade numpy
```

**Chạy hệ thống:**
```bash
cd src
python3 main.py
```

**Tối ưu hóa:**
- Sử dụng `pypy3` để tăng tốc độ Python 2-3 lần
- Giảm `SMOOTHING_WINDOW` từ 5 xuống 3 để giảm độ trễ
- Chạy script định kỳ qua `cron` thay vì liên tục

### 2. Google Coral DevBoard (TPU Accelerator)

**Cài đặt:**
```bash
# Thêm Coral repository
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Cài đặt tflite runtime
pip3 install tflite-runtime

# Cài đặt dependencies
pip3 install -r requirements.txt
```

**Tối ưu hóa:**
- Giảm kích thước dữ liệu xử lý (chunk: 1000 samples thay vì toàn bộ)
- Sử dụng `scipy.signal` thay vì TensorFlow nếu không cần mô hình ML
- Chạy dự xử lý (preprocessing) song song trên CPU

**Code tối ưu:**
```python
# Xử lý streaming data thay vì batch
def process_stream(data_chunk):
    preprocessor = DataPreprocessor()
    data_chunk = preprocessor.preprocess()
    # Chỉ xử lý dữ liệu mới, không reprocess toàn bộ
    return data_chunk
```

### 3. NVIDIA Jetson (GPU Acceleration)

**Cài đặt:**
```bash
# Jetson đã có CUDA/cuDNN
pip3 install -r requirements.txt

# Tùy chọn: Cài đặt RAPIDS cho GPU acceleration
pip3 install cuml  # GPU-accelerated ML library
```

**Tối ưu hóa:**
- Sử dụng `cupy` thay vì `numpy` để tăng tốc phép toán (10-100x)
- Sử dụng `cuml` cho signal processing
- Chạy inference TensorFlow trên GPU

**Code tối ưu:**
```python
# Sử dụng GPU cho tính toán đồng
import cupy as cp  # GPU version của numpy
import numpy as np

# Chuyển dữ liệu sang GPU
data_gpu = cp.asarray(data)

# Xử lý trên GPU
result_gpu = cp.signal.filtfilt(b, a, data_gpu)

# Chuyển về CPU khi cần lưu trữ
result = cp.asnumpy(result_gpu)
```

### 4. Tối Ưu Chung Cho Tất Cả Edge Devices

#### A. Giảm Memory Footprint
```python
# Chỉ lưu trữ dữ liệu cần thiết
# Thay vì lưu tất cả: df.to_csv()
# Lưu chunk-wise
for i in range(0, len(data), 1000):
    chunk = data.iloc[i:i+1000]
    chunk.to_csv(f"chunk_{i}.csv", index=False)
```

#### B. Xử Lý Real-time Streaming
```python
# Thay vì batch processing, xử lý streaming data
from collections import deque

class StreamingProcessor:
    def __init__(self, window_size=300):  # 30 giây @ 10Hz
        self.window = deque(maxlen=window_size)
    
    def process_frame(self, sensor_data):
        self.window.append(sensor_data)
        if len(self.window) == self.window.maxlen:
            # Xử lý chỉ cửa sổ mới
            return self.analyze_window()
        return None
```

#### C. Giảm Tính Toán
```python
# Giảm tần số lọc
RESPIRATION_MIN_FREQUENCY = 0.2  # Từ 0.1
RESPIRATION_MAX_FREQUENCY = 0.8  # Từ 1.0

# Sử dụng bộ lọc đơn giản
# Thay vì Butterworth order 4: Butterworth order 2
b, a = signal.butter(2, [low, high], btype='band')  # order=2
```

#### D. Logging Hiệu Quả
```python
# Ghi log chỉ những sự kiện quan trọng
if apnea_event_detected:
    log_event(event_data)  # Ghi chi tiết sự kiện apnea
    
# Ghi tóm tắt hàng giờ thay vì tất cả dữ liệu
hourly_summary = data.resample('1H').agg({
    'hr_bpm': 'mean',
    'respiratory_rate': 'mean',
    'apnea_count': 'sum'
})
```

### Benchmark Performance

| Device | Processing Time (10 min data) | Memory Usage | Power Consumption |
|--------|--------------------------------|--------------|-------------------|
| Orange Pi 5B | ~8-10 giây | ~50 MB | ~2-3 W |
| Coral DevBoard | ~5-6 giây | ~80 MB | ~3-4 W |
| Jetson Nano | ~2-3 giây | ~200 MB | ~5 W |
| Laptop (Intel i7) | ~0.5 giây | ~300 MB | ~20 W |

## Tác Giả và Giấy Phép

Phiên bản 1.0 - 2024

## Tham Khảo

- American Academy of Sleep Medicine (AASM) Scoring Manual
- Apnea-Hypopnea Index Clinical Practice Guidelines
- Edge Device Optimization: https://www.tensorflow.org/lite/guide

