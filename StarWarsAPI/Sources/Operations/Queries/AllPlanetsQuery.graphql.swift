// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AllPlanetsQuery: GraphQLQuery {
  public static let operationName: String = "AllPlanets"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AllPlanets($after: String) { allPlanets(first: 10, after: $after) { __typename totalCount pageInfo { __typename endCursor hasNextPage } edges { __typename cursor node { __typename id name diameter rotationPeriod orbitalPeriod gravity population climates terrains surfaceWater filmConnection { __typename totalCount } created edited } } } }"#
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
      .field("allPlanets", AllPlanets?.self, arguments: [
        "first": 10,
        "after": .variable("after")
      ]),
    ] }

    public var allPlanets: AllPlanets? { __data["allPlanets"] }

    /// AllPlanets
    ///
    /// Parent Type: `PlanetsConnection`
    public struct AllPlanets: StarWarsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.PlanetsConnection }
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

      /// AllPlanets.PageInfo
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

      /// AllPlanets.Edge
      ///
      /// Parent Type: `PlanetsEdge`
      public struct Edge: StarWarsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.PlanetsEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("cursor", String.self),
          .field("node", Node?.self),
        ] }

        /// A cursor for use in pagination
        public var cursor: String { __data["cursor"] }
        /// The item at the end of the edge
        public var node: Node? { __data["node"] }

        /// AllPlanets.Edge.Node
        ///
        /// Parent Type: `Planet`
        public struct Node: StarWarsAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Planet }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", StarWarsAPI.ID.self),
            .field("name", String?.self),
            .field("diameter", Int?.self),
            .field("rotationPeriod", Int?.self),
            .field("orbitalPeriod", Int?.self),
            .field("gravity", String?.self),
            .field("population", Double?.self),
            .field("climates", [String?]?.self),
            .field("terrains", [String?]?.self),
            .field("surfaceWater", Double?.self),
            .field("filmConnection", FilmConnection?.self),
            .field("created", String?.self),
            .field("edited", String?.self),
          ] }

          /// The ID of an object
          public var id: StarWarsAPI.ID { __data["id"] }
          /// The name of this planet.
          public var name: String? { __data["name"] }
          /// The diameter of this planet in kilometers.
          public var diameter: Int? { __data["diameter"] }
          /// The number of standard hours it takes for this planet to complete a single
          /// rotation on its axis.
          public var rotationPeriod: Int? { __data["rotationPeriod"] }
          /// The number of standard days it takes for this planet to complete a single orbit
          /// of its local star.
          public var orbitalPeriod: Int? { __data["orbitalPeriod"] }
          /// A number denoting the gravity of this planet, where "1" is normal or 1 standard
          /// G. "2" is twice or 2 standard Gs. "0.5" is half or 0.5 standard Gs.
          public var gravity: String? { __data["gravity"] }
          /// The average population of sentient beings inhabiting this planet.
          public var population: Double? { __data["population"] }
          /// The climates of this planet.
          public var climates: [String?]? { __data["climates"] }
          /// The terrains of this planet.
          public var terrains: [String?]? { __data["terrains"] }
          /// The percentage of the planet surface that is naturally occuring water or bodies
          /// of water.
          public var surfaceWater: Double? { __data["surfaceWater"] }
          public var filmConnection: FilmConnection? { __data["filmConnection"] }
          /// The ISO 8601 date format of the time that this resource was created.
          public var created: String? { __data["created"] }
          /// The ISO 8601 date format of the time that this resource was edited.
          public var edited: String? { __data["edited"] }

          /// AllPlanets.Edge.Node.FilmConnection
          ///
          /// Parent Type: `PlanetFilmsConnection`
          public struct FilmConnection: StarWarsAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.PlanetFilmsConnection }
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
