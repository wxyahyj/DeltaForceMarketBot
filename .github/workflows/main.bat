@echo off
chcp 65001 >nul

echo ========================================
echo DeltaForceMarketBot 打包脚本
echo ========================================
echo 注意：使用本工具可能违反游戏协议，导致账号封禁
echo ========================================

:: 检查Python是否安装
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：未找到Python环境，请先安装Python并添加到系统PATH
    pause
    exit /b 1
)

:: 安装项目依赖
echo 正在安装项目依赖...
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
if %errorlevel% neq 0 (
    echo 错误：安装依赖失败，请检查网络连接
    pause
    exit /b 1
)

:: 安装PyInstaller
echo 正在安装PyInstaller...
pip install pyinstaller -i https://pypi.tuna.tsinghua.edu.cn/simple
if %errorlevel% neq 0 (
    echo 错误：安装PyInstaller失败，请检查网络连接
    pause
    exit /b 1
)

:: 执行打包命令（无控制台模式）
echo 正在打包程序...
pyinstaller --onefile --noconsole DFMarketBot.py
if %errorlevel% neq 0 (
    echo 错误：打包失败，请查看以上错误信息
    pause
    exit /b 1
)

:: 检查dist目录是否存在
if exist dist (
    echo 打包成功！可执行文件位于 dist\DFMarketBot.exe
    echo 请确保将image文件夹与可执行文件放在同一目录下
) else (
    echo 警告：打包完成，但未找到dist目录
)

pause
