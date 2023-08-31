# We add the known data to perform an analysis of significance between acne treatments

y1 <- c(95, 32, 97, 75, 83, 84, 73, 68)
y2 <- c(85, 90, 79, 50, 32, 84, 78, 95, 65, 80)
y3 <- c(79, 92, 64, 68, 76, 20, 37, 74, 86)

improvement <- c(y1, y2, y3)
treatment <- c(rep("1", 8), rep("2", 10), rep("3", 9))
treatment <- as.factor(treatment)
is.factor(treatment)
a <- length(levels(treatment))
data <- data.frame(improvement, treatment)
str(data)

# We define the variables that will be necessary to obtain the Fw statistic

n1 <- length(y1)
n2 <- length(y2)
n3 <- length(y3)

w <- c(n1 / var(y1), n2 / var(y2), n3 / var(y3))
w_sum <- sum(w)
ybar <- (w[1] * mean(y1) + w[2] * mean(y2) + w[3] * mean(y3)) / w_sum
A <- 1 / (n1 - 1) * (1 - w[1] / w_sum) + (1 / (n2 - 1)) * (1 - w[2] / w_sum) + (1 / (n3 - 1)) * (1 - w[3] / w_sum)
x <- c(w[1] * (mean(y1) - ybar)^2, w[2] * (mean(y2) - ybar)^2, w[3] * (mean(y3) - ybar)^2)

# We define the Fw statistic using its mathematical formula:

Fw <- (1 / (a - 1) * sum(x)) / (1 + (2 * (a - 2) * A) / (a^2 - 1))

# Display the value of the statistic

Fw

# We use the Snedecor's F contrast with degrees of freedom v1 = a - 1 and v2 = (a^2 - 1) / 3 * A

qf(0.95, a - 1, (a^2 - 1) / (3 * A))

# Taking into account the null hypothesis:
# H0: There are no significant differences between the treatments
# We analyze if the value is in the critical region, in which case we would reject Ho (Fw > Fv1, v2; 0.05)
# If it's outside the region, we wouldn't have evidence to reject Ho (Fw < Fv1, v2; 0.05)
# In this case, since Fw < Fv1, v2, 0.05, we conclude that we don't reject H0, meaning
# there are no significant differences between the acne treatments.




