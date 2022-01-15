protocol HomeService {
    func getBeerList(page: Int, completion: @escaping ([HomeModel]) -> ())
}
