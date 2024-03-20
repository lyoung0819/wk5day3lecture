from unittest import TestCase, main
from whiteboard import solution



class MatchTestCase(TestCase):
    def test_general_1(self):
        self.assertEqual(solution(4), 3)
    def test_general_2(self):
        self.assertEqual(solution(6), 8)
    def test_general_3(self):
        self.assertEqual(solution(16), 60)
    def test_low_test1(self):
        self.assertEqual(solution(3), 0)
    def test_low_test2(self):
        self.assertEqual(solution(5), 3)
    def test_high_test(self):
        self.assertEqual(solution(15), 45)