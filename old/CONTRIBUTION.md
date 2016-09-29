#Team Best Practices

*All this to be confirmed*
<br>
Just a gentle reminder checklist

##Development
###General
- Work with the git branch model. Please refer to [this](http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/) blog for more information on `git flow`.
- Register all enhancements, bugs & questions in the issue list
- Follow (style guide)[]

###Checklist before merging in `develop`
- Issue registered in github and commit message contains `Fixes #<issue_number>`.
- Test code present.
- Code complies to design.
- Documentation updated.
- [TBC](https://github.com/malcommac/SwiftDate/issues/134) Make sure that code coverage is not lower than before adding the code.
- Tests successfully with Travis.
- Documentation is updated.
- Consensus in the team (especially with Daniele).

##Release
- Overall quality check: code style, code test coverage, documentation, minimum deployment targets (OSX 10.10, iOS 8.0, tvOS 9.0, watchOS 2.0)
- `git flow release start`
- Assess all issues and close those that were resolved
- [Generate](https://github.com/skywinder/Github-Changelog-Generator) the change log
- `git flow release finish`
