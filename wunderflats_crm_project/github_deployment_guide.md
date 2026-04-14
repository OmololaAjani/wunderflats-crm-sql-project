# Beginner's Guide to Deploying Your SQL CRM Project on GitHub

This guide will walk you through the process of setting up a Git repository, committing your project files, and pushing them to GitHub. This is a fundamental skill for any developer or data professional and will allow you to share your work with others, including potential employers.

## What is Git and GitHub?

- **Git**: A version control system that tracks changes in any set of computer files, usually used for coordinating work among programmers collaboratively developing source code during software development. It's like a 
powerful "undo" button for your entire project.
- **GitHub**: A web-based platform that uses Git for version control. It's a hosting service for Git repositories, allowing for collaboration, code sharing, and project management. Think of it as a social network for code.

## Step-by-Step Deployment Guide

### Step 1: Install Git

If you don't have Git installed on your computer, you'll need to install it first. You can download it from the official Git website:

[Download Git](https://git-scm.com/downloads)

Follow the installation instructions for your operating system. You can verify the installation by opening your terminal or command prompt and typing:

```bash
git --version
```

### Step 2: Create a GitHub Account

If you don't already have one, sign up for a free GitHub account:

[Sign up for GitHub](https://github.com/join)

### Step 3: Create a New Repository on GitHub

1.  Log in to your GitHub account.
2.  On the top right corner, click the "+" sign and select "New repository."
3.  **Repository name**: Choose a descriptive name for your project, e.g., `wunderflats-crm-sql-project`.
4.  **Description (Optional)**: Provide a brief overview of your project.
5.  **Public or Private**: Select "Private" if you only want to share it with specific people (like a hiring manager). Select "Public" if you want anyone to see it.
6.  **Initialize this repository with a README**: **DO NOT** check this box. We will be adding our own `README.md` file.
7.  Click "Create repository."

After creating the repository, GitHub will show you a page with instructions. Keep this page open, as you'll need the repository URL.

### Step 4: Initialize a Local Git Repository

1.  Open your terminal or command prompt.
2.  Navigate to your project directory. In this case, it would be `wunderflats_crm_project`:

    ```bash
    cd wunderflats_crm_project
    ```

3.  Initialize a new Git repository in your project folder:

    ```bash
    git init
    ```

    This command creates a hidden `.git` directory in your project folder, which Git uses to track changes.

### Step 5: Add Your Files to the Repository

1.  Tell Git to start tracking all files in your project directory:

    ```bash
    git add .
    ```

    The `.` means "add all files in the current directory and its subdirectories."

2.  Commit your changes. A commit is like saving a snapshot of your project at a specific point in time. Every commit needs a message describing the changes:

    ```bash
    git commit -m "Initial commit: Add SQL schema, seed data, and CRM queries"
    ```

### Step 6: Link Your Local Repository to GitHub

1.  Go back to the GitHub page for your newly created repository. Copy the URL (it will look something like `https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git`).
2.  In your terminal, add the remote origin. Replace `YOUR_REPOSITORY_URL` with the URL you copied:

    ```bash
    git remote add origin YOUR_REPOSITORY_URL
    ```

    Example:
    ```bash
    git remote add origin https://github.com/yourusername/wunderflats-crm-sql-project.git
    ```

### Step 7: Push Your Project to GitHub

Finally, push your local commits to your GitHub repository:

```bash
git push -u origin main
```

- `git push`: Sends your committed changes to the remote repository.
- `-u origin main`: Sets the `main` branch on `origin` (your GitHub repository) as the upstream branch. This means that subsequent `git push` and `git pull` commands will automatically know which remote branch to interact with.

    *Note: GitHub recently changed the default branch name from `master` to `main`. If your local Git is still using `master`, you might need to use `git push -u origin master` or rename your local branch to `main` first (`git branch -M main`).*

### Step 8: Verify on GitHub

Go to your GitHub repository page in your web browser and refresh it. You should now see all your project files (`sql/`, `README.md`, `github_deployment_guide.md`) listed there!

## Sharing Your Private Repository

If you created a private repository, you can invite collaborators (like a hiring manager) to view it:

1.  On your GitHub repository page, click on "Settings."
2.  In the left sidebar, click "Collaborators and teams."
3.  Click "Add people" and enter the GitHub username or email of the person you want to invite.

They will receive an invitation to view your repository.

Congratulations! You've successfully deployed your SQL CRM project to GitHub. This demonstrates not only your SQL skills but also your proficiency with version control, a critical skill in any technical role.
