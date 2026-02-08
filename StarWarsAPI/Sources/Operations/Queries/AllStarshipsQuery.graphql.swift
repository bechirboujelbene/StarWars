// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AllStarshipsQuery: GraphQLQuery {
  public static let operationName: String = "AllStarships"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AllStarships($after: String) { allStarships(first: 10, after: $after) { __typename totalCount pageInfo { __typename endCursor hasNextPage } edges { __typename cursor node { __typename id name model manufacturers costInCredits length maxAtmospheringSpeed crew passengers cargoCapacity consumables hyperdriveRating MGLT starshipClass filmConnection { __typename totalCount } created edited } } } }"#
    ))

  public var after: GraphQLNullable<String>

  public init(after: GraphQLNullable<String>) {
    self.after = after
  }

  public var __variables: Variables? { ["after": after] }

  public struct Data: StarWarsAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("allStarships", AllStarships?.self, arguments: [
        "first": 10,
        "after": .variable("after")
      ]),
    ] }

    public var allStarships: AllStarships? { __data["allStarships"] }

    /// AllStarships
    ///
    /// Parent Type: `StarshipsConnection`
    public struct AllStarships: StarWarsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.StarshipsConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("totalCount", Int?.self),
        .field("pageInfo", PageInfo.self),
        .field("edges", [Edge?]?.self),
      ] }

      /// A count of the total number of objects in this connection, ignoring pagination.
      /// This allows a client to fetch the first five objects by passing "5" as the
      /// argument to "first", then fetch the total count so it could display "5 of 83",
      /// for example.
      public var totalCount: Int? { __data["totalCount"] }
      /// Information to aid in pagination.
      public var pageInfo: PageInfo { __data["pageInfo"] }
      /// A list of edges.
      public var edges: [Edge?]? { __data["edges"] }

      /// AllStarships.PageInfo
      ///
      /// Parent Type: `PageInfo`
      public struct PageInfo: StarWarsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.PageInfo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("endCursor", String?.self),
          .field("hasNextPage", Bool.self),
        ] }

        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? { __data["endCursor"] }
        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool { __data["hasNextPage"] }
      }

      /// AllStarships.Edge
      ///
      /// Parent Type: `StarshipsEdge`
      public struct Edge: StarWarsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.StarshipsEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("cursor", String.self),
          .field("node", Node?.self),
        ] }

        /// A cursor for use in pagination
        public var cursor: String { __data["cursor"] }
        /// The item at the end of the edge
        public var node: Node? { __data["node"] }

        /// AllStarships.Edge.Node
        ///
        /// Parent Type: `Starship`
        public struct Node: StarWarsAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Starship }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", StarWarsAPI.ID.self),
            .field("name", String?.self),
            .field("model", String?.self),
            .field("manufacturers", [String?]?.self),
            .field("costInCredits", Double?.self),
            .field("length", Double?.self),
            .field("maxAtmospheringSpeed", Int?.self),
            .field("crew", String?.self),
            .field("passengers", String?.self),
            .field("cargoCapacity", Double?.self),
            .field("consumables", String?.self),
            .field("hyperdriveRating", Double?.self),
            .field("MGLT", Int?.self),
            .field("starshipClass", String?.self),
            .field("filmConnection", FilmConnection?.self),
            .field("created", String?.self),
            .field("edited", String?.self),
          ] }

          /// The ID of an object
          public var id: StarWarsAPI.ID { __data["id"] }
          /// The name of this starship. The common name, such as "Death Star".
          public var name: String? { __data["name"] }
          /// The model or official name of this starship. Such as "T-65 X-wing" or "DS-1
          /// Orbital Battle Station".
          public var model: String? { __data["model"] }
          /// The manufacturers of this starship.
          public var manufacturers: [String?]? { __data["manufacturers"] }
          /// The cost of this starship new, in galactic credits.
          public var costInCredits: Double? { __data["costInCredits"] }
          /// The length of this starship in meters.
          public var length: Double? { __data["length"] }
          /// The maximum speed of this starship in atmosphere. null if this starship is
          /// incapable of atmosphering flight.
          public var maxAtmospheringSpeed: Int? { __data["maxAtmospheringSpeed"] }
          /// The number of personnel needed to run or pilot this starship.
          public var crew: String? { __data["crew"] }
          /// The number of non-essential people this starship can transport.
          public var passengers: String? { __data["passengers"] }
          /// The maximum number of kilograms that this starship can transport.
          public var cargoCapacity: Double? { __data["cargoCapacity"] }
          /// The maximum length of time that this starship can provide consumables for its
          /// entire crew without having to resupply.
          public var consumables: String? { __data["consumables"] }
          /// The class of this starships hyperdrive.
          public var hyperdriveRating: Double? { __data["hyperdriveRating"] }
          /// The Maximum number of Megalights this starship can travel in a standard hour.
          /// A "Megalight" is a standard unit of distance and has never been defined before
          /// within the Star Wars universe. This figure is only really useful for measuring
          /// the difference in speed of starships. We can assume it is similar to AU, the
          /// distance between our Sun (Sol) and Earth.
          public var mglt: Int? { __data["MGLT"] }
          /// The class of this starship, such as "Starfighter" or "Deep Space Mobile
          /// Battlestation"
          public var starshipClass: String? { __data["starshipClass"] }
          public var filmConnection: FilmConnection? { __data["filmConnection"] }
          /// The ISO 8601 date format of the time that this resource was created.
          public var created: String? { __data["created"] }
          /// The ISO 8601 date format of the time that this resource was edited.
          public var edited: String? { __data["edited"] }

          /// AllStarships.Edge.Node.FilmConnection
          ///
          /// Parent Type: `StarshipFilmsConnection`
          public struct FilmConnection: StarWarsAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.StarshipFilmsConnection }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("totalCount", Int?.self),
            ] }

            /// A count of the total number of objects in this connection, ignoring pagination.
            /// This allows a client to fetch the first five objects by passing "5" as the
            /// argument to "first", then fetch the total count so it could display "5 of 83",
            /// for example.
            public var totalCount: Int? { __data["totalCount"] }
          }
        }
      }
    }
  }
}
