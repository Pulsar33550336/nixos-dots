{
  lib,
  ...
}:
{
  programs.zsh.initContent = lib.mkAfter ''
    # QR码识别函数
    qrdecode() {
        if [[ $# -eq 0 ]]; then
            echo "用法: qrdecode <图片文件>"
            echo "示例: qrdecode qrcode.png"
            return 1
        fi

        local image_file="$1"

        # 检查文件是否存在
        if [[ ! -f "$image_file" ]]; then
            echo "错误: 文件 '$image_file' 不存在"
            return 1
        fi

        # 检查文件类型
        if ! file "$image_file" | grep -q "image"; then
            echo "错误: '$image_file' 不是有效的图片文件"
            return 1
        fi

        # 发送请求到API
        local response
        response=$(curl -s -X POST \
            -F "file=@$image_file" \
            "https://api.2dcode.biz/v1/read-qr-code")

        # 检查curl是否成功
        if [[ $? -ne 0 ]]; then
            echo "错误: 网络请求失败"
            return 1
        fi

        # 解析JSON响应
        local contents
        if command -v jq >/dev/null 2>&1; then
            contents=$(echo "$response" | jq -r '.data.contents // empty')
        else
            # 如果没有jq，使用grep和sed简单提取
            contents=$(echo "$response" | grep -o '"contents":"[^"]*"' | head -1 | sed 's/"contents":"\([^"]*\)"/\1/')
        fi

        if [[ -n "$contents" ]]; then
            echo "识别到的二维码内容: $contents"
            # 可选：复制到剪贴板（macOS）
            if command -v pbcopy >/dev/null 2>&1; then
                echo "$contents" | pbcopy
                echo "内容已复制到剪贴板"
            fi
        else
            echo "错误: 无法识别二维码内容"
            echo "API响应: $response"
            return 1
        fi
    }

    # 自动补全支持
    _qrdecode() {
        _files -g "*.(png|jpg|jpeg|gif|bmp)"
    }

    compdef _qrdecode qrdecode
  '';
}
