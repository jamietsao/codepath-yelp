## CodePath Spring 2015 - Week 2 Homework: Yelp App

This is a Yelp search app using the [Yelp API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: ~ 25 hours

### Known Issues
- When Search Results page is first displayed, long business names are truncated instead of wrapping even though constraints appear correct.  This is apparently a known bug as mentioned by Tim in this video (https://vimeo.com/109911790), but his suggested fix didn't work for me and made the experience much worst so I decided to leave the bug as is.

### Features

#### Required

- [ X ] Search results page
   - [ X ] Table rows should be dynamic height according to the content height
   - [ X ] Custom cells should have the proper Auto Layout constraints
   - [ X ] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [ X ] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [ X ] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
   - [ X ] The filters table should be organized into sections as in the mock.
   - [ X ] You can use the default UISwitch for on/off states. Optional: implement a custom switch
   - [ X ] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [ X ] Display some of the available Yelp categories (choose any 3-4 that you want) - I DECIDED TO SHOW THEM ALL.

#### Optional

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results
   - [ ] Implement map view of restaurant results
- [ ] Filter page
   - [ ] Radius filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list (Links to an external site.)
- [ ] Implement the restaurant detail page.
- [ X ] Selected filters are remembered when you visit Filter page again after a search
- [ X ] Implemented "Cancel" button on Filter page that takes you back to Search Results page without performing a new search.  Previously selected filters are still remembered if you go back to Filter page
- [ X ] Implemented the ability to select multiple category filters (e.g. "Chinese" & "Comfort Food")
- [ X ] Customized Nav Bar color to Yelp red, and text to white.  Status bar text to white as well

### Walkthrough

![Video Walkthrough](FeaturesWalkthrough.gif)


