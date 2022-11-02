final class ListPopularMoviePresenter: ListPopularMovieViewToPresenterProtocol {
    var view: ListPopularMoviePresenterToViewProtocol?
    
    var interactor: ListPopularMoviePresenterToInteractorProtocol?
    
    func updateView() {
        self.interactor?.fetchListPopularMovie(with: .popular)
    }
    
    func getResult() -> [MovieListResponse.Result]? {
        return self.interactor?.response?.results
    }
    
    func getNumberOfCount() -> Int? {
        return self.interactor?.response?.results?.count
    }   
}

extension ListPopularMoviePresenter: ListPopularMovieInteractorToPresenterProtocol {
    func isLoading(isLoading: Bool) {
        view?.showLoading(isLoading: isLoading)
    }
    
    func listPopularMovieFetched() {
        view?.showView()
    }
    
    func listPopularMovieFetchedFailed() {
        view?.showError()
    }
}
