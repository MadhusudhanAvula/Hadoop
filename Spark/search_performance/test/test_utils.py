import unittest

from app.utils import utils


class TestUtils(unittest.TestCase):

    def test_get_domain(self):
        self.assertEqual(utils.get_domain("https://www.adobe.com/search_performace/testing"), "adobe.com",
                         "get the domain from url")


if __name__ == "__main__":
    unittest.main()
