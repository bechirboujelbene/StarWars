// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AllPeopleQuery: GraphQLQuery {
  public static let operationName: String = "AllPeople"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AllPeople($after: String) { allPeople(first: 10, after: $after) { __typename totalCount pageInfo { __typename endCursor hasNextPage } edges { __typename cursor node { __typename id name height mass birthYear hairColor eyeColor skinColor gender homeworld { __typename name } species { __typename name } filmConnection { __typename totalCount } created edited } } } }"#
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
      .field("allPeople", AllPeople?.self, arguments: [
        "first": 10,
        "after": .variable("after")
      ]),
    ] }

    public var allPeople: AllPeople? { __data["allPeople"] }

    /// AllPeople
    ///
    /// Parent Type: `PeopleConnection`
    public struct AllPeople: StarWarsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.PeopleConnection }
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

      /// AllPeople.PageInfo
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

      /// AllPeople.Edge
      ///
      /// Parent Type: `PeopleEdge`
      public struct Edge: StarWarsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.PeopleEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("cursor", String.self),
          .field("node", Node?.self),
        ] }

        /// A cursor for use in pagination
        public var cursor: String { __data["cursor"] }
        /// The item at the end of the edge
        public var node: Node? { __data["node"] }

        /// AllPeople.Edge.Node
        ///
        /// Parent Type: `Person`
        public struct Node: StarWarsAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Person }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", StarWarsAPI.ID.self),
            .field("name", String?.self),
            .field("height", Int?.self),
            .field("mass", Double?.self),
            .field("birthYear", String?.self),
            .field("hairColor", String?.self),
            .field("eyeColor", String?.self),
            .field("skinColor", String?.self),
            .field("gender", String?.self),
            .field("homeworld", Homeworld?.self),
            .field("species", Species?.self),
            .field("filmConnection", FilmConnection?.self),
            .field("created", String?.self),
            .field("edited", String?.self),
          ] }

          /// The ID of an object
          public var id: StarWarsAPI.ID { __data["id"] }
          /// The name of this person.
          public var name: String? { __data["name"] }
          /// The height of the person in centimeters.
          public var height: Int? { __data["height"] }
          /// The mass of the person in kilograms.
          public var mass: Double? { __data["mass"] }
          /// The birth year of the person, using the in-universe standard of BBY or ABY -
          /// Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is
          /// a battle that occurs at the end of Star Wars episode IV: A New Hope.
          public var birthYear: String? { __data["birthYear"] }
          /// The hair color of this person. Will be "unknown" if not known or "n/a" if the
          /// person does not have hair.
          public var hairColor: String? { __data["hairColor"] }
          /// The eye color of this person. Will be "unknown" if not known or "n/a" if the
          /// person does not have an eye.
          public var eyeColor: String? { __data["eyeColor"] }
          /// The skin color of this person.
          public var skinColor: String? { __data["skinColor"] }
          /// The gender of this person. Either "Male", "Female" or "unknown",
          /// "n/a" if the person does not have a gender.
          public var gender: String? { __data["gender"] }
          /// A planet that this person was born on or inhabits.
          public var homeworld: Homeworld? { __data["homeworld"] }
          /// The species that this person belongs to, or null if unknown.
          public var species: Species? { __data["species"] }
          public var filmConnection: FilmConnection? { __data["filmConnection"] }
          /// The ISO 8601 date format of the time that this resource was created.
          public var created: String? { __data["created"] }
          /// The ISO 8601 date format of the time that this resource was edited.
          public var edited: String? { __data["edited"] }

          /// AllPeople.Edge.Node.Homeworld
          ///
          /// Parent Type: `Planet`
          public struct Homeworld: StarWarsAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Planet }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String?.self),
            ] }

            /// The name of this planet.
            public var name: String? { __data["name"] }
          }

          /// AllPeople.Edge.Node.Species
          ///
          /// Parent Type: `Species`
          public struct Species: StarWarsAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Species }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String?.self),
            ] }

            /// The name of this species.
            public var name: String? { __data["name"] }
          }

          /// AllPeople.Edge.Node.FilmConnection
          ///
          /// Parent Type: `PersonFilmsConnection`
          public struct FilmConnection: StarWarsAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.PersonFilmsConnection }
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
