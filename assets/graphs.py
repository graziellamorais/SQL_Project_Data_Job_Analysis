import matplotlib.pyplot as plt
import pandas as pd
import os

# Set a consistent style for all plots
plt.style.use('seaborn-v0_8-whitegrid')

# --- Plot 1: Top 10 Paying Jobs ---
try:
    # Use the specific absolute file path provided by the user
    file_path = 'csv_files/1_top_paying_jobs.csv'
    df_jobs = pd.read_csv(file_path)

    # Create a unique job label by combining job title and company name
    df_jobs['job_label'] = df_jobs['job_title'] + ' (' + df_jobs['company_name'] + ')'

    # Sort data for better visualization
    df_jobs = df_jobs.sort_values(by='salary_year_avg', ascending=False)

    # Create a horizontal bar chart
    fig, ax1 = plt.subplots(figsize=(12, 8))
    bars1 = ax1.barh(df_jobs['job_label'], df_jobs['salary_year_avg'], color='skyblue', height=0.6)

    # Add value labels to the bars
    for bar in bars1:
        ax1.text(bar.get_width(), bar.get_y() + bar.get_height()/2, 
                f'${bar.get_width():,.0f}', va='center', ha='left', fontsize=10, color='black',
                bbox=dict(boxstyle="round,pad=0.3", fc='white', ec='none', alpha=0.7))

    # Customize the chart
    ax1.set_title('Top Highest-Paying Data Analyst Jobs', fontsize=18, fontweight='bold', pad=20)
    ax1.set_xlabel('Average Salary (USD)', fontsize=12)
    ax1.set_ylabel('Job Title', fontsize=12)
    ax1.invert_yaxis()  # To display the highest salary at the top
    ax1.xaxis.grid(True, linestyle='--', alpha=0.6)

    # Remove the top and right spines
    ax1.spines['top'].set_visible(False)
    ax1.spines['right'].set_visible(False)

    # Adjust layout
    plt.tight_layout()
    plt.savefig('top_paying_jobs.png')
    plt.close(fig)
    print("Chart for Top Paying Jobs created successfully.")
except FileNotFoundError:
    print(f"Error: The file '{file_path}' was not found. Please check the file path.")

# --- Plot 2: Top Paying Job Skills ---
try:
    df_skills_jobs = pd.read_csv('csv_files/2_top_paying_job_skills.csv')
    skill_counts = df_skills_jobs['skills'].value_counts()
    skill_counts = skill_counts.sort_values(ascending=False)
    fig, ax2 = plt.subplots(figsize=(10, 7))
    bars2 = ax2.barh(skill_counts.index, skill_counts.values, color='coral', height=0.6)
    for bar in bars2:
        ax2.text(bar.get_width(), bar.get_y() + bar.get_height()/2, 
                f'{int(bar.get_width())}', va='center', ha='left', fontsize=10, color='black',
                bbox=dict(boxstyle="round,pad=0.3", fc='white', ec='none', alpha=0.7))
    ax2.set_title('Skills Required for Top-Paying Jobs', fontsize=18, fontweight='bold', pad=20)
    ax2.set_xlabel('Number of Mentions', fontsize=12)
    ax2.set_ylabel('Skills', fontsize=12)
    ax2.invert_yaxis()
    ax2.spines['top'].set_visible(False)
    ax2.spines['right'].set_visible(False)
    plt.tight_layout()
    plt.savefig('top_paying_job_skills.png')
    plt.close(fig)
except FileNotFoundError:
    print("Error: The file 'csv_files/2_top_paying_job_skills.csv' was not found.")


# --- Plot 3: Most Demanded Skills ---
try:
    df_demanded = pd.read_csv('csv_files/3_top_demanded_skills.csv')
    df_demanded = df_demanded.sort_values(by='demand_count', ascending=False)
    fig, ax3 = plt.subplots(figsize=(10, 7))
    bars3 = ax3.bar(df_demanded['skills'], df_demanded['demand_count'], color='teal', width=0.6)
    for bar in bars3:
        yval = bar.get_height()
        ax3.text(bar.get_x() + bar.get_width()/2, yval, 
                f'{int(yval)}', ha='center', va='bottom', fontsize=10, color='black',
                bbox=dict(boxstyle="round,pad=0.3", fc='white', ec='none', alpha=0.7))
    ax3.set_title('Top 5 Most Demanded Skills', fontsize=18, fontweight='bold', pad=20)
    ax3.set_xlabel('Skills', fontsize=12)
    ax3.set_ylabel('Demand Count', fontsize=12)
    plt.xticks(rotation=45, ha='right')
    ax3.spines['top'].set_visible(False)
    ax3.spines['right'].set_visible(False)
    plt.tight_layout()
    plt.savefig('top_demanded_skills.png')
    plt.close(fig)
except FileNotFoundError:
    print("Error: The file 'csv_files/3_top_demanded_skills.csv' was not found.")

# --- Plot 4: Top Paying Skills ---
try:
    df_paying_skills = pd.read_csv('csv_files/4_top_paying_skills.csv')
    df_paying_skills = df_paying_skills.sort_values(by='avg_salary', ascending=True)
    fig, ax4 = plt.subplots(figsize=(12, 8))
    bars4 = ax4.barh(df_paying_skills['skills'], df_paying_skills['avg_salary'], color='purple', height=0.6)
    for bar in bars4:
        ax4.text(bar.get_width(), bar.get_y() + bar.get_height()/2, 
                f'${bar.get_width():,.0f}', va='center', ha='left', fontsize=10, color='black',
                bbox=dict(boxstyle="round,pad=0.3", fc='white', ec='none', alpha=0.7))
    ax4.set_title('Top 10 Highest-Paying Skills', fontsize=18, fontweight='bold', pad=20)
    ax4.set_xlabel('Average Salary (USD)', fontsize=12)
    ax4.set_ylabel('Skills', fontsize=12)
    ax4.spines['top'].set_visible(False)
    ax4.spines['right'].set_visible(False)
    plt.tight_layout()
    plt.savefig('top_paying_skills.png')
    plt.close(fig)
except FileNotFoundError:
    print("Error: The file 'csv_files/4_top_paying_skills.csv' was not found.")

# --- Plot 5: Optimal Skills ---
try:
    df_optimal = pd.read_csv('csv_files/5_optimal_skills.csv')
    fig, ax5 = plt.subplots(figsize=(12, 8))
    scatter = ax5.scatter(
        x=df_optimal['avg_salary'], 
        y=df_optimal['demand_count'], 
        s=df_optimal['demand_count'] * 100,
        alpha=0.6,
        edgecolors='w',
        c=['teal', 'coral', 'skyblue', 'purple']
    )
    for i, txt in enumerate(df_optimal['skills']):
        ax5.annotate(
            txt, 
            (df_optimal['avg_salary'][i], df_optimal['demand_count'][i]),
            textcoords="offset points",
            xytext=(0, 10),
            ha='center',
            fontsize=10,
            fontweight='bold'
        )
    ax5.set_title('Optimal Skills: Demand vs. Average Salary', fontsize=18, fontweight='bold', pad=20)
    ax5.set_xlabel('Average Salary (USD)', fontsize=12)
    ax5.set_ylabel('Demand Count', fontsize=12)
    ax5.set_xlim(df_optimal['avg_salary'].min() * 0.95, df_optimal['avg_salary'].max() * 1.1)
    ax5.set_ylim(df_optimal['demand_count'].min() * 0.9, df_optimal['demand_count'].max() * 1.1)
    ax5.grid(True, linestyle='--', alpha=0.6)
    ax5.spines['top'].set_visible(False)
    ax5.spines['right'].set_visible(False)
    plt.tight_layout()
    plt.savefig('optimal_skills.png')
    plt.close(fig)
except FileNotFoundError:
    print("Error: The file 'csv_files/5_optimal_skills.csv' was not found.")

print("All charts have been created successfully.")
