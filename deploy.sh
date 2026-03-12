#!/bin/bash

# ToyPulse 网站部署脚本
# 使用方法: ./deploy.sh

echo "🎨 ToyPulse 潮玩脉搏 - GitHub Pages 部署脚本"
echo "============================================"
echo ""

# 检查是否安装了 git
if ! command -v git &> /dev/null; then
    echo "❌ 错误: 未安装 Git"
    echo "请先安装 Git: https://git-scm.com/downloads"
    exit 1
fi

# 检查是否配置了 git 用户名和邮箱
if ! git config --global user.name &> /dev/null || ! git config --global user.email &> /dev/null; then
    echo "⚠️  请先配置 Git 用户名和邮箱:"
    echo "   git config --global user.name '你的名字'"
    echo "   git config --global user.email '你的邮箱'"
    exit 1
fi

echo "✅ Git 已配置"
echo ""

# 提示用户输入 GitHub 信息
echo "请输入你的 GitHub 用户名:"
read USERNAME

echo ""
echo "请输入仓库名称 (建议: toypulse-website):"
read REPO_NAME

if [ -z "$REPO_NAME" ]; then
    REPO_NAME="toypulse-website"
fi

echo ""
echo "📦 正在准备部署..."
echo "   用户名: $USERNAME"
echo "   仓库名: $REPO_NAME"
echo ""

# 添加远程仓库
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$USERNAME/$REPO_NAME.git"

echo "🔗 远程仓库已配置"
echo ""

# 推送代码
echo "📤 正在推送代码到 GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 代码推送成功!"
    echo ""
    echo "🌐 接下来请在 GitHub 上完成以下步骤:"
    echo ""
    echo "   1. 访问: https://github.com/$USERNAME/$REPO_NAME/settings/pages"
    echo ""
    echo "   2. 在 'Source' 部分选择 'Deploy from a branch'"
    echo ""
    echo "   3. 选择 'main' 分支, 然后点击 'Save'"
    echo ""
    echo "   4. 等待 1-2 分钟, 然后访问:"
    echo "      https://$USERNAME.github.io/$REPO_NAME"
    echo ""
    echo "🎉 部署完成后, 你的网站就可以访问了!"
else
    echo ""
    echo "❌ 推送失败"
    echo ""
    echo "可能的原因:"
    echo "   1. GitHub 仓库不存在 - 请先创建仓库"
    echo "   2. 没有权限 - 请检查用户名和仓库名是否正确"
    echo "   3. 需要登录 - 运行: gh auth login"
    echo ""
    echo "手动创建仓库步骤:"
    echo "   1. 访问 https://github.com/new"
    echo "   2. 仓库名称填写: $REPO_NAME"
    echo "   3. 选择 'Public' (公开)"
    echo "   4. 点击 'Create repository'"
    echo "   5. 然后重新运行此脚本"
fi
