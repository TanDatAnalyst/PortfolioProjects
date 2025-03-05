# BANK LOAN ANALYSIS

SELECT *
FROM bank_loan_data
;

# SỐ LƯỢNG GIAO DỊCH
# Có bao nhiêu bản ghi trong tập data? 38 576
SELECT COUNT(id) AS Total_Loan_Applications
FROM bank_loan_data
;

# Giả sử hôm nay là ngày trong tháng 12/2021.
# Hãy đếm số lượng đơn vay từ đầu tháng đến nay (Month-to-Date): 4314
SELECT COUNT(id) AS MTD_Loan_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
;

# Đếm số lượng đơn vay của tháng 11/2021 để tính tăng trưởng theo tháng: 4035
SELECT COUNT(id) AS Pre_MTD_Loan_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
;
# Công thức: Month-over-Month Growth = (Giá trị tháng hiện tại/Giá trị tháng trước)-1 
# 									 = (Giá trị tháng hiện tại-Giá trị tháng trước)/Giá trị tháng trước
SELECT
	ROUND((COUNT(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN id END) 
		 / COUNT(CASE WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN id END) - 1) * 100, 2)
	AS MoM_Loan_Applications
FROM bank_loan_data
;
# Vậy số lượng đơn vay trong tháng hiện tại đã tăng 6.91% so với tháng trước.


# LƯỢNG TIỀN NGÂN HÀNG CHO VAY
# Tính tổng số tiền được ngân hàng cho vay: 435 757 075 (USD)
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
;

# Số tiền được cho vay trong tháng này là: 53 981 425 (USD)
SELECT SUM(loan_amount) AS MTD_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
;

# Số tiền được cho vay trong tháng trước là: 47 754 825 (USD)
SELECT SUM(loan_amount) AS Pre_MTD_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
;
SELECT
	ROUND((SUM(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN loan_amount END) 
		 / SUM(CASE WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN loan_amount END) - 1) * 100, 2)
	AS MoM_Funded_Amount 
FROM bank_loan_data
;
# Vậy số tiền cho vay trong tháng này tăng 13.04% so với tháng trước.


# LƯỢNG TIỀN NGÂN HÀNG NHẬN VỀ (NGƯỜI VAY TRẢ NỢ)
# Tính tổng số tiền ngân hàng nhận về: 473 070 933 (USD)
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
;

# Số tiền nhận về trong tháng này là: 58 074 380 (USD)
SELECT SUM(total_payment) AS MTD_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
;

# Số tiền nhận về trong tháng trước là: 50 132 030 (USD)
SELECT SUM(total_payment) AS Pre_MTD_Amount_Received 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
;
SELECT
	ROUND((SUM(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN total_payment END) 
		 / SUM(CASE WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN total_payment END) - 1) * 100, 2)
	AS MoM_Amount_Received 
FROM bank_loan_data
;
# Vậy số tiền ngân hàng nhận về trong tháng này tăng 15.84% so với tháng trước.


# LÃI SUẤT TRUNG BÌNH
# Lãi suất trung bình của tất cả khoản vay là: 12.05%
SELECT ROUND(AVG(int_rate),4)*100 AS Avg_Interest_Rate
FROM bank_loan_data
;

# Lãi suất trung bình của các khoản vay tháng này xấp xỉ bằng: 12.36%
SELECT ROUND(AVG(int_rate) * 100, 2) AS MTD_Avg_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
;

# Lãi suất trung bình của các khoản vay tháng trước xấp xỉ bằng: 11.94%
SELECT ROUND(AVG(int_rate) * 100, 2) AS Pre_MTD_Avg_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
;
SELECT
	ROUND((AVG(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN int_rate END)
		 / AVG(CASE WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN int_rate END) - 1) * 100, 2)
	AS MoM_Avg_Interest_Rate
FROM bank_loan_data
;
# Vậy lãi suất vay trung bình trong tháng này tăng xấp xỉ 3.47% so với tháng trước.


# TỶ LỆ NỢ TRÊN THU NHẬP TRUNG BÌNH - Average Dept-to-Income
# DTI trung bình cho tất cả các khoản vay xấp xỉ bằng: 13.33%
SELECT ROUND(AVG(dti) * 100, 2) AS Avg_DTI
FROM bank_loan_data
;

# DTI trung bình của các khoản vay tháng này xấp xỉ bằng: 13.67%
SELECT ROUND(AVG(dti) * 100, 2) AS MTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
;

# DTI trung bình của các khoản vay tháng trước xấp xỉ bằng: 13.30%
SELECT ROUND(AVG(dti) * 100, 2) AS Pre_MTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
;
SELECT
	ROUND((AVG(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN dti END)
		 / AVG(CASE WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN dti END) - 1) * 100, 2)
	AS MoM_Avg_DTI
FROM bank_loan_data
;
# Vậy DTI trung bình của các khoản vay trong tháng này tăng xấp xỉ 2.73% so với tháng trước.


SELECT *
FROM bank_loan_data
;

# GOOD LOAN vs BAD LOAN
# KHOẢN VAY TỐT:
# Số lượng khoản vay tốt: 33243
SELECT COUNT(id) AS Good_loan_applications 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
;

# Tỷ lệ khoản vay tốt trên toàn bộ các khoản vay: 86.18%
SELECT
	ROUND(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) / COUNT(id) * 100, 2) 
    	AS Good_loan_percentage
FROM bank_loan_data
;

# Tổng lượng tiền ngân hàng cho vay trong các khoản vay tốt: 370 224 850 (USD)
SELECT SUM(loan_amount) AS Good_loan_Funded_Amount 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
;

# Tổng lượng tiền ngân hàng nhận về trong các khoản vay tốt: 435 786 170 (USD)
SELECT SUM(total_payment) AS Good_loan_Amount_Received 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
;

# KHOẢN VAY XẤU:
# Số lượng khoản vay xấu: 5333
SELECT COUNT(id) AS Bad_loan_applications 
FROM bank_loan_data
WHERE loan_status = 'Charged Off'
;

# Tỷ lệ khoản vay xấu trên toàn bộ các khoản vay: 13.82%
SELECT
	ROUND(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) / COUNT(id) * 100, 2) 
    	AS Bad_loan_percentage
FROM bank_loan_data
;

# Tổng lượng tiền ngân hàng cho vay trong các khoản vay xấu: 65 532 225 (USD)
SELECT SUM(loan_amount) AS Bad_loan_Funded_Amount 
FROM bank_loan_data
WHERE loan_status = 'Charged Off'
;

# Tổng lượng tiền ngân hàng nhận về trong các khoản vay xấu: 37 284 763 (USD)
SELECT SUM(total_payment) AS Bad_loan_Amount_Received 
FROM bank_loan_data
WHERE loan_status = 'Charged Off'
;


# PHÂN TÍCH THEO LOAN STATUS - TÌNH TRẠNG KHOẢN VAY
SELECT loan_status, 
       COUNT(id) AS Total_Loan_Applications, 
       SUM(loan_amount) AS Total_Funded_Amount,
       SUM(total_payment) AS Total_Amount_Received,
       ROUND(AVG(int_rate) * 100, 2) AS AVG_Interest_Rate,
       ROUND(AVG(dti) * 100, 2) AS AVG_DTI
FROM bank_loan_data
GROUP BY loan_status
ORDER BY loan_status DESC
;

SELECT loan_status, 
       COUNT(id) AS MTD_Applications, 
       SUM(loan_amount) AS MTD_Funded_Amount,
       SUM(total_payment) AS MTD_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY loan_status
ORDER BY loan_status DESC
;

SELECT *
FROM bank_loan_data
;

# PHÂN TÍCH TỔNG QUAN VỀ SỐ LƯỢNG KHOẢN VAY, TIỀN NGÂN HÀNG CHO VAY VÀ NHẬN VỀ
# Theo thời gian (tháng):
SELECT 
	MONTH(issue_date) AS Month_Number,
	MONTHNAME(issue_date) AS Month_Name,
    	COUNT(id) AS Total_Loan_Applications,
    	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number
;

# Theo nơi chốn (tiểu bang Mỹ):
SELECT 
	address_state,
    	COUNT(id) AS Total_Loan_Applications,
    	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY Total_Funded_Amount DESC
;

# Theo kỳ hạn khoản vay (36 tháng hoặc 60 tháng):
SELECT 
	term,
    	COUNT(id) AS Total_Loan_Applications,
    	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term
;

# Theo số năm đi làm:
SELECT 
	emp_length,
    	COUNT(id) AS Total_Loan_Applications,
    	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY Total_Loan_Applications DESC
;

# Theo mục đích:
SELECT 
	purpose,
    	COUNT(id) AS Total_Loan_Applications,
    	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY Total_Loan_Applications DESC
;

# Theo tình trạng sở hữu nhà
SELECT 
	home_ownership,
    	COUNT(id) AS Total_Loan_Applications,
    	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY Total_Loan_Applications DESC
;
