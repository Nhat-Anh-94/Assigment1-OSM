#!/bin/bash

# Tệp kết quả đầu ra
readonly outputFile="final_ex5.txt"

# Xóa nội dung cũ của tệp đầu ra
> "$outputFile"

# Các tệp đầu vào
fileNames=("pre_a_exp5.txt" "pre_b_exp5.txt" "pre_c_exp5.txt")

# Biến tổng cho các giá trị FAIL, PASS, NOTCHECK
totalFail=0
totalPass=0
totalNotcheck=0

# Mảng chứa tổng giá trị của từng tệp
sums=()

# Xử lý từng tệp trong mảng
for fileName in "${fileNames[@]}"; do
    # Kiểm tra tệp tồn tại
    if [[ ! -f $fileName ]]; then
        echo "Tệp $fileName không tồn tại. Bỏ qua." >> "$outputFile"
        sums+=(0)
        continue
    fi

    # Biến đếm cho từng loại
    failCount=0
    passCount=0
    notcheckCount=0

    # Đọc từng dòng trong tệp
    while IFS= read -r line || [[ -n $line ]]; do
        case "$line" in
            FAIL:*)
                value=${line#*: }
                if [[ "$value" =~ ^[0-9]+$ ]]; then
                    failCount=$((failCount + value))
                else
                    echo "Dòng không hợp lệ trong $fileName: $line" >> "$outputFile"
                fi
                ;;
            PASS:*)
                value=${line#*: }
                if [[ "$value" =~ ^[0-9]+$ ]]; then
                    passCount=$((passCount + value))
                else
                    echo "Dòng không hợp lệ trong $fileName: $line" >> "$outputFile"
                fi
                ;;
            NOTCHECK:*)
                value=${line#*: }
                if [[ "$value" =~ ^[0-9]+$ ]]; then
                    notcheckCount=$((notcheckCount + value))
                else
                    echo "Dòng không hợp lệ trong $fileName: $line" >> "$outputFile"
                fi
                ;;
            *)
                echo "Dòng không hợp lệ trong $fileName: $line" >> "$outputFile"
                ;;
        esac
    done < "$fileName"

    # Tính tổng FAIL + PASS + NOTCHECK cho từng tệp
    sum=$((failCount + passCount + notcheckCount))
    sums+=($sum)

    # Cộng vào tổng toàn bộ
    totalFail=$((totalFail + failCount))
    totalPass=$((totalPass + passCount))
    totalNotcheck=$((totalNotcheck + notcheckCount))
done

# Ghi kết quả tổng vào tệp đầu ra
{
    echo "FAIL: $totalFail"
    echo "PASS: $totalPass"
    echo "NOTCHECK: $totalNotcheck"
    echo "****"
    echo "SUM1: ${sums[0]:-0}"
    echo "SUM2: ${sums[1]:-0}"
    echo "SUM3: ${sums[2]:-0}"
} >> "$outputFile"
