# Customer Segmentation and Product Recommendation for ACME Innovations
![Customer Segmentation Product Recommendation engine](https://github.com/user-attachments/assets/b7fc385a-34e2-44a7-86fb-ef218aec4b55)

## Project Overview
This repository contains the Data Science project for Acme Innovations, a legacy household name facing declining customer retention rates. This project is part of the Data Mining and Business Intelligence course in the Master's program. The project aims to leverage advanced data science techniques to understand customer behavior, identify growth opportunities, optimize marketing strategies, and enhance customer retention.
## Academic Context

Course: Data Mining and Business Intelligence

Program: Master's Degree in Business Analytics

Institution: University of New Haven

Semester: 2nd Semester

## Repository Structure

- Proposal for Acme Innovations.pdf: Detailed project proposal document
- Presentation for ACME Innovations.pdf: Presentation document
- Customer Segmentation - Product Recommendation Project.R: R code for data analysis and modeling
- customer_data.csv: Dataset containing customer information (not included in the repository)
- customer_purchase_history_final.csv: Dataset containing customer purchase history (not included in the repository)
- README.md: This file, provides an overview of the project

## Project Highlights
### Data Catalyst Consultancy
Motto: Catalyzing Growth through Data
### Methodologies Used

**1. KNN Clustering for Customer Segmentation**

- Features used: salary and spending score
- Data scaling for unbiased clustering
- Optimal cluster determination using the elbow method
- Visualization of clusters using ggplot2


**2. Apriori Algorithm for Product Recommendation**

- Preprocessing of transaction data
- Careful setting of support and confidence thresholds
- Rule generation and evaluation using support, confidence, and lift metrics



### Key Findings

- Customer segmentation revealed distinct clusters based on salary and spending score
- Identified high-salary customers with low spending scores as potential targets for revenue increase
- Discovered product combinations with high support and confidence scores for targeted recommendations

### Recommendations

- Focus marketing efforts on high-salary, low-spending customers to increase revenue
- Offer loyalty program memberships to high-spending customers for recurring revenue
- Leverage product recommendations with high support and confidence scores for cross-selling
- Implement personalized marketing strategies based on customer segments

## How to Use This Repository

1. Clone the repository to your local machine.
2. Review the **Proposal for Acme Innovations.pdf** for a detailed project overview and methodology.
3. Examine the **Customer Segmentation - Product Recommendation Project.R** file for the complete data analysis and modeling process.
4. Ensure you have R and the required packages installed (see Dependencies section).
5. Place the customer_data.csv and customer_purchase_history_final.csv files in the appropriate directory.
6. Run the R script to reproduce the analysis and generate insights.

## Dependencies
The following R packages are required to run the analysis:

- readr
- datasets
- cluster
- caTools
- ggplot2
- stringr
- arules

Install these packages using install.packages() if you haven't already.
## Future Improvements

1. Implement more advanced product recommendation techniques, such as collaborative filtering
2. Incorporate time series analysis to understand customer behavior trends over time
3. Develop a predictive model for customer churn
4. Create an interactive dashboard for real-time monitoring of key metrics
5. Integrate external data sources for more comprehensive analysis

## Academic Integrity Statement
This project is submitted as part of the requirements for the Data Mining and Business Intelligence course. It represents my own work and adheres to the academic integrity policies of the University of New Haven. All sources used have been properly cited and acknowledged.
## Contributing
While this is primarily an academic project, constructive feedback and suggestions for improvement are welcome. Please feel free to open an issue or submit a pull request if you have any insights to share.
## License
This project is licensed under the MIT License - see the LICENSE.md file for details.
## Contact
For any questions or feedback regarding this project, please contact:

Aris

Email: mailaristotle@gmail.com

