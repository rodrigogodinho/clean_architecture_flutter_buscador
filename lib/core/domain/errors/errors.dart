abstract class FailureSearch implements Exception {}

class InvalidTextError implements FailureSearch {}

class InvalidEmptyTextError implements FailureSearch {}

class DataSourceError implements FailureSearch {}

class InvalidTypeOfViewSearchResult implements FailureSearch {}
