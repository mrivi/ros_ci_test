#include <gtest/gtest.h>

#include "../include/offboard_node.h"


TEST(Common, sum) {
	int a = 5;
	int b = 6;

	int result = sum_integers(a, b);

	EXPECT_EQ(11, result);
	EXPECT_EQ(0, result);
}