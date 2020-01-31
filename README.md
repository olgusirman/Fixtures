A developer at your company has been working on a fixtures app for Hull City Tigers. The app uses the football-data.org API to fetch matches and display them to the user.

You've inherited their unfinished project, and a design mockup (attached). It looks like the project might have some bugs, and the user interface definitely needs some work.

Your job is to add the missing features below, refactoring and fixing any bugs you might come across and prioritising as you see fit. Feel free to re-work any aspect of the codebase you’re not happy with, within the bounds of the original spec.

Requirements: 

Architecture:
- Structure should be migrated to MVVM
- Seperate the different layers (service, model, business logic, views)
- Write unit tests
- Use git for version control, committing early and often

The app should show:
- List the matches in a chronological order with results shown first
- Display scores for previous matches and a countdown to the next match
- Display the date, competition and venue of each match

You should spend no more than 4-5 hours on the project - we know this isn’t anywhere near enough time to complete the spec, so no pressure to build all the features or fix all the bugs! We’re interested to see how far you get in that time and the decisions you make along the way. Please update the README below, briefly explaining:
- What were your priorities, and why?
- If you had more time, what would you have tackled next? - what would you change about the structure of the code?
- What bugs did you find but not fix?
- What would you change about the visual design of the app?

We know it’s tough to find a spare few hours, so there's no hard deadline - if you're busy or travelling right now and won’t find time in the next week or so, please let us know so we don’t check-in with you too early!

- My priorities were create a flexible reactive structure first give some hints about my previous project structures, especially on service part, because I realized I might not be handled all the challange features because of strict time, after that manipulate the data would be easy for me. Such as, I didn’t realize I need also teams data first, but after that I Implemented teams endpoint and updated teams inside the matches object. Also I know with flexible structure, writing unit tests would be easy, because of that I use Moya instead of RxAlamofire, Moya has cool sampleData extension help me to supply mock data easily.
- If I had more time, I wouldn’t hardcoded HullCity team id, I would fetch the teams first, find Hull City Id and after that fetching HullCity matches. I would also implement Swinject - Dependency Injection framework. It wasn’t my priority because I used constructor injection idea that all Services and ViewModels get their dependencies from outside, but If I would have so many pages It would be really hard to maintain and configure all the injections, So that I didn’t prioritize Swinject first. Maybe I would prepare better ErrorHandler for this architecture. Also I used system fonts and system colors for this project, That would also needs to be handled in elegant way, creating assets for colors, or using RSwift for resource management, or just simple extensions for UIFont. 
- Beginning of the project, after the data fetched, UI tried to be updated in another queue. UI layers should be update in mainQueue and developers should check any strong ownerships inside the closures and prevent with using weak and unowned. ( If object is self dependent and you are sure that never going to be nil, unowned should be used, otherwise weak should be used. ) 
- I'd find a another way to clearly differentiate 3 states of games such as played / playing / to be played, I would represent this states with icons if its possible instead of changing the backgroundColor with related to selected team color. I would use a generic and simple design language for match cells, maybe looks like a card with little bit shadow below it (because skeumorphisim kind of a trend again these days :) and only use main parameters inside the cell such as result, team names - icons, time, and carry the other logics ( stadium name and countdown, if Its live showing the match details goals, red cards and special moments etc.) with detail page. Yes I would also be create detail page and show that related datas, I also use new UIContextMenu as well for show that detail page. That light design language also help me to get rid of usage of gray separators that logic in it. 
