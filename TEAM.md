#Team Best Practices

*All this to be confirmed*
<br>
Just a gentle reminder checklist

##Development
###General
- Work with the git branch model. Please refer to [this](http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/) blog for more information on `git flow`.
- Register all enhancements, bugs & questions in the issue list
- [TBC](https://github.com/malcommac/SwiftDate/issues/131) Follow style guide


###Checklist before merging in `develop`
- Issue registered in github.
- Test code present.
- Documentation updated.
- [TBC](https://github.com/malcommac/SwiftDate/issues/134) Make sure that code coverage is not lower than before adding the code.
- Tests successfully with Travis.
- Documentation is updated.
- Concensus in the team (especially with Daniele).

##Release
- Check for code coverage of tests
- Quality check for documentation
- `git flow release start`
- Assess all issues and close those that were resolved
- [Generate](https://github.com/skywinder/Github-Changelog-Generator) the change log
- `git flow release finish`
