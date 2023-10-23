library(ggplot2)
library(ezids)
library(gplot)
library(dplyr)

df <- data.frame(read.csv('final_dataset.csv'))
head(df)

#EDA
summary(df) #数据描述性统计
sum(is.na(df)) #检验是否有缺失值

colnames(df)[colnames(df) == "cab_type"] <- "cab_company" #修改列名
colnames(df)[colnames(df) == "name"] <- "cab_type"

#df$hour <- case_when(
#  (df$hour >= 8 & df$hour <= 10) | (df$hour >= 17 & df$hour <= 20) ~ 3,  # 高峰时间
#  df$hour >= 11 & df$hour <= 13 ~ 2,                                     # 次高峰时间
#  TRUE ~ 1                                                               # 低峰时间
#)

unique(df$cab_company) #查看数据中打车公司一共几家
unique(df$cab_type) #查看数据中打车的类型有几种

head(df)


# Group by 'hour' and calculate the mean of 'price'
df_hour_price <- aggregate(df$price, by=list(hour=df$hour), FUN=mean)

# Rename the columns to match the Python code
colnames(df_hour_price) <- c("hour", "mean_price")

# Create a figure with two subplots
par(mfrow=c(1, 2), mar=c(5, 4, 4, 2))  # 1 row, 2 columns

# Plot histograms by cab_type for Lyft
hist(df$price[df$cab_company == "Lyft"], col="orange", xlab="Price", ylab="Frequency", main="Histogram of Prices by Cab Type (Lyft)")

# Plot histograms by cab_type for Uber
hist(df$price[df$cab_company == "Uber"], col="blue", xlab="Price", ylab="Frequency", main="Histogram of Prices by Cab Type (Uber)")

# Add legend to the figure
legend("topright", legend=c("Uber", "Lyft"), fill=c("blue", "orange"))



# Create a ggplot object
p <- ggplot(df, aes(x = cab_type, y = price, fill = cab_type)) +
  geom_boxplot(width = 0.5) +  # Adjust the width
  labs(x = "Cab Type", y = "Price", title = "Boxplot of Prices by Cab Type")

# Adjust the width and height of the plot
p + theme_minimal() + theme(legend.position = "none") + 
  theme(plot.title = element_text(hjust = 0.5, size = 14)) + 
  theme(axis.text = element_text(size = 12), axis.title = element_text(size = 14)) + 
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5)) + 
  theme(plot.margin = unit(c(1, 2, 1, 1), "cm"))




# Scatter plot: Examine the relationship between price and distance
ggplot(df, aes(x = distance, y = price)) +
  geom_point(aes(color = price), alpha = 0.5) +    # Use color to represent the value of price and set point transparency to 0.5
  labs(title = "The Plot of Price vs. Distance",    # Chart title
       x = "Distance",                              # x-axis title
       y = "Price",                                 # y-axis title
       color = "Price Value") +                     # Legend title
  theme_minimal()                                   # Use a minimalistic theme

# Box plot: Examine the distribution of price across different surge multipliers
ggplot(df, aes(x = factor(surge_multiplier), y = price)) +  # Convert surge_multiplier to factor for a clearer plot
  geom_boxplot(aes(fill = factor(surge_multiplier))) +        # Fill boxes with colors based on surge_multiplier
  labs(title = "Boxplot of Price across Different Surge Multipliers",
       x = "Surge Multiplier",
       y = "Price",
       fill = "Surge Multiplier Categories") +
  theme_minimal()



# measure of variance
sd(df$price)
sd(df$distance)
sd(df$surge_multiplier)

# Create a histogram
hist(df$hour)

# Create a Q-Q plot
qqnorm(df$hour)
qqline(df$hour)

# Create a density plot
plot(density(df$hour))


# Create a histogram
hist(df$price)

# Create a Q-Q plot
qqnorm(df$price)
qqline(df$price)
plot(density(df$price))

# Create a histogram
hist(df$distance)

# Create a Q-Q plot
qqnorm(df$distance)
qqline(df$distance)
plot(density(df$distance))

# Create a histogram
hist(df$surge_multiplier)

# Create a Q-Q plot
qqnorm(df$surge_multiplier)
qqline(df$surge_multiplier)
plot(density(df$surge_multiplier))


#对数字类型变量作相关系数热力图
df_numeric <- df[,1:4] #取数字型变量
cor_matrix <- cor(df_numeric) #相关系数矩阵

heatmap.2(cor_matrix, 
          main = "Correlation Heatmap",  # 图表标题
          key = TRUE,  # 显示颜色键
          density.info = "none",  # 防止颜色键的重复
          trace = "none",  # 防止绘制追踪线
          cellnote = round(cor_matrix, 2),  # 显示相关系数的值
          notecol = "black",  # 文本标签颜色
          margins = c(5, 5),  # 设置图表边距
          col = colorRampPalette(c("blue", "white", "red"))(100)  # 颜色映射
)


# 执行卡方检验
chisq_result <- chisq.test(df$cab_company, df$cab_type)

chisq_result


#linear regression analysis
linear_model <- lm(price~distance + surge_multiplier + hour,data = df)
summary(linear_model)







