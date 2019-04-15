
import unittest
import os
from random import randint
from appium import webdriver
from time import sleep
from selenium.webdriver.common.keys import Keys

class LoginTests(unittest.TestCase):
    
    def setUp(self):
        app = ('/Users/habib/Library/Developer/Xcode/DerivedData/Task-dtvkqbgbvijuwvftgdxpjulbebmb/Build/Products/Debug-iphonesimulator/Task.app')
        
        self.driver = webdriver.Remote(
                                       command_executor='http://127.0.0.1:4723/wd/hub',
                                       desired_capabilities={
                                       'app': app,
                                       'platformName': 'iOS',
                                       'platformVersion': '12.2',
                                       'deviceName': 'iPhone 7',
                                       'automationName': 'XCUITest',
                                       'noReset': True
                                       }
                                       )
    
    def tearDown(self):
        self.driver.quit()
    
    def testTableView(self):
        tableView = self.driver.find_element_by_accessibility_id('tableView')
        sleep(2)
        repoCell = self.driver.find_element_by_accessibility_id('RepoCell')
        repoCell.click()

    def testNoteTextView(self):
        self.testTableView()
        noteTextView = self.driver.find_element_by_accessibility_id('noteTextView')
        noteTextView.send_keys('hello world')
        sleep(2)
        self.assertEqual(noteTextView.get_attribute('value'), 'hello world')

    def testSaveNoteButton(self):
        self.testTableView()
        saveButton = self.driver.find_element_by_accessibility_id('saveNoteButton')
        sleep(1)
        self.assertTrue(saveButton)

    def testEditButton(self):
        self.testTableView()
        editButton = self.driver.find_element_by_accessibility_id('editNoteButton')
        sleep(1)
        self.assertTrue(editButton)


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(LoginTests)
    unittest.TextTestRunner(verbosity=2).run(suite)

