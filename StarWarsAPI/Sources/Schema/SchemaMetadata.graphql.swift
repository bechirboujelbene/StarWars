// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == StarWarsAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == StarWarsAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == StarWarsAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == StarWarsAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Film": return StarWarsAPI.Objects.Film
    case "PageInfo": return StarWarsAPI.Objects.PageInfo
    case "PeopleConnection": return StarWarsAPI.Objects.PeopleConnection
    case "PeopleEdge": return StarWarsAPI.Objects.PeopleEdge
    case "Person": return StarWarsAPI.Objects.Person
    case "PersonFilmsConnection": return StarWarsAPI.Objects.PersonFilmsConnection
    case "Planet": return StarWarsAPI.Objects.Planet
    case "PlanetFilmsConnection": return StarWarsAPI.Objects.PlanetFilmsConnection
    case "PlanetsConnection": return StarWarsAPI.Objects.PlanetsConnection
    case "PlanetsEdge": return StarWarsAPI.Objects.PlanetsEdge
    case "Query": return StarWarsAPI.Objects.Query
    case "Species": return StarWarsAPI.Objects.Species
    case "Starship": return StarWarsAPI.Objects.Starship
    case "StarshipFilmsConnection": return StarWarsAPI.Objects.StarshipFilmsConnection
    case "StarshipsConnection": return StarWarsAPI.Objects.StarshipsConnection
    case "StarshipsEdge": return StarWarsAPI.Objects.StarshipsEdge
    case "Vehicle": return StarWarsAPI.Objects.Vehicle
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
