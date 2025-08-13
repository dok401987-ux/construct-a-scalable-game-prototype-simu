// 207e_construct_a_sca.swift
// Construct a Scalable Game Prototype Simulator

import Foundation
import GameplayKit

// MARK: - Game Entity

struct GameEntity {
    let id: Int
    let name: String
    var position: CGPoint
    var velocity: CGPoint
}

// MARK: - Game Simulator

class GameSimulator {
    private var entities: [GameEntity] = []
    private let gridSize: CGSize
    private let entityManager: EntityManager

    init(gridSize: CGSize) {
        self.gridSize = gridSize
        self.entityManager = EntityManager(gridSize: gridSize)
    }

    func addEntity(_ entity: GameEntity) {
        entities.append(entity)
    }

    func simulate(deltaTime: TimeInterval) {
        for entity in entities {
            entityManager.updateEntity(entity, deltaTime: deltaTime)
        }
    }

    func getEntity(at position: CGPoint) -> GameEntity? {
        return entityManager.getEntity(at: position)
    }
}

// MARK: - Entity Manager

class EntityManager {
    private let gridSize: CGSize
    private var entityGrid: [[GameEntity?]] = []

    init(gridSize: CGSize) {
        self.gridSize = gridSize
        self.entityGrid = Array(repeating: Array(repeating: nil, count: Int(gridSize.width)), count: Int(gridSize.height))
    }

    func updateEntity(_ entity: GameEntity, deltaTime: TimeInterval) {
        // Update entity position based on velocity
        entity.position.x += entity.velocity.x * CGFloat(deltaTime)
        entity.position.y += entity.velocity.y * CGFloat(deltaTime)

        // Wrap entity around the grid
        entity.position.x = fmod(entity.position.x, gridSize.width)
        entity.position.y = fmod(entity.position.y, gridSize.height)

        // Update entity grid
        updateEntityGrid(entity)
    }

    func getEntity(at position: CGPoint) -> GameEntity? {
        return entityGrid[Int(position.y)][Int(position.x)]
    }

    private func updateEntityGrid(_ entity: GameEntity) {
        entityGrid[Int(entity.position.y)][Int(entity.position.x)] = entity
    }
}

// MARK: - Game Simulation Loop

func gameSimulationLoop(simulator: GameSimulator, deltaTime: TimeInterval) {
    simulator.simulate(deltaTime: deltaTime)

    // Handle user input
    // Render game state
    // Update UI
}

// MARK: - Example Usage

let gridSize = CGSize(width: 10, height: 10)
let simulator = GameSimulator(gridSize: gridSize)

let entity1 = GameEntity(id: 1, name: " Entity 1", position: CGPoint(x: 0, y: 0), velocity: CGPoint(x: 1, y: 0))
let entity2 = GameEntity(id: 2, name: " Entity 2", position: CGPoint(x: 5, y: 5), velocity: CGPoint(x: 0, y: -1))

simulator.addEntity(entity1)
simulator.addEntity(entity2)

while true {
    gameSimulationLoop(simulator: simulator, deltaTime: 1.0 / 60.0)
}