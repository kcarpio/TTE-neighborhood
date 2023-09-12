## Example data frame
dat <- data.frame(
  Index = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), ## This provides an order to the data
  label = c("Weeks et al. (2022)\n Overall", "Weeks et al. (2022)\n non-Hispanic Black", "Weeks et al. (2022)\n Hispanic", "Weeks et al. (2022)\n non-Hispanic other race", "Njoroge et al. (2021)", "Daoud et al. (2019)\n non-Immigrant Jewish", "Daoud et al. (2019)\n Immigrant Jewish", "Daoud et al. (2019)\n Palestinian-Arab", "Bécares et al. (2016)\n One experience\n of lifetime discrimination", "Bécares et al. (2016)\n More than one experience\n of lifetime discrimination"),
  OR = c(2.70, 3.5, 2.2, 2.2, 1.71, 1.75, 3.46, 1.70, 1.49, 1.51),
  LL = c(2.2, 2.6, 1.4, 1.5, 1.09, 0.86, 1.36, 0.97, 1.08, 1.08),
  UL = c(3.4, 4.8, 3.4, 3.3, 2.68, 3.54, 8.83, 2.99, 2.05, 2.11),
  CI = c("2.2, 3.4", "2.6, 4.8", "1.4, 3.4", "1.5, 3.3", "1.09, 2.68", "0.86, 3.54", "1.36, 8.83", "0.97, 2.99", "1.08, 2.05", "1.08, 2.11")
)
dat

## Plot forest plot
plot1 <- ggplot(dat, aes(y = Index, x = OR)) +
  geom_point(shape = 18, size = 5) +  
  geom_errorbarh(aes(xmin = LL, xmax = UL), height = 0.25) +
  geom_vline(xintercept = 1, color = "red", linetype = "dashed", cex = 1, alpha = 0.5) +
  scale_y_continuous(name = "", breaks=1:10, labels = dat$label, trans = "reverse") +
  xlab("Odds Ratio (95% CI)") + 
  ylab(" ") + 
  theme_bw() +
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.y = element_text(size = 12, colour = "black"),
        axis.text.x.bottom = element_text(size = 12, colour = "black"),
        axis.title.x = element_text(size = 12, colour = "black"))
plot1

## Create the table-base pallete
table_base <- ggplot(dat, aes(y=label)) +
  ylab(NULL) + xlab("  ") + 
  theme(plot.title = element_text(hjust = 0.5, size=12), 
        axis.text.x = element_text(color="white", hjust = -3, size = 25), ## This is used to help with alignment
        axis.line = element_blank(),
        axis.text.y = element_blank(), 
        axis.ticks = element_blank(),
        axis.title.y = element_blank(), 
        legend.position = "none",
        panel.background = element_blank(), 
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        plot.background = element_blank())

## OR point estimate table
tab1 <- table_base + 
  labs(title = "space") +
  geom_text(aes(y = rev(Index), x = 1, label = sprintf("%0.1f", round(OR, digits = 1))), size = 4) + ## decimal places
  ggtitle("OR")

## 95% CI table
tab2 <- table_base +
  geom_text(aes(y = rev(Index), x = 1, label = CI), size = 4) + 
  ggtitle("95% CI")

lay <-  matrix(c(1,1,1,1,1,1,1,1,1,1,2,3,3), nrow = 1)
grid.arrange(plot1, tab1, tab2, layout_matrix = lay)
