using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class MapManager : MonoBehaviour {

	public GameObject[] outWallArray;
	public GameObject[] floorArray;
	public GameObject[] wallArray;
	public GameObject[] foodArray;
	public GameObject[] enemyArray;
	public GameObject exitPrefab;

	public int rows = 10;
	public int cols = 10;
	public int minWallCount = 2;
	public int maxWallCount = 10;
	public int foodCount = 2;
	public int enemyCount = 3;

	private Transform mapHolder;
	private List<Vector2> positionList = new List<Vector2>();
	private GameManager gameManager;

	public void InitMap() {
		gameManager = this.GetComponent<GameManager>();
		mapHolder = new GameObject("Map").transform;
		for(int x=0; x<cols; x++) {
			for(int y=0; y<rows; y++) {
				if(x==0 || y==0 || x==cols-1 || y==rows-1) {
					int index = Random.Range(0,outWallArray.Length);
					GameObject go = GameObject.Instantiate(outWallArray[index], new Vector3(x,y,0),Quaternion.identity) as GameObject;
					go.transform.SetParent(mapHolder);
				}
				else {
					int index = Random.Range(0,floorArray.Length);
					GameObject go = GameObject.Instantiate(floorArray[index], new Vector3(x,y,0),Quaternion.identity) as GameObject;
					go.transform.SetParent(mapHolder);
				}
			}
		}

		positionList.Clear();
		for(int x=2; x<cols-2; x++){
			for(int y=2; y<rows-2; y++){
				positionList.Add(new Vector2(x,y));
			}
		}

		//创建障碍物
		int wallCount = Random.Range(minWallCount, maxWallCount+1);
		InstantiateItems(wallCount, wallArray);
		//创建食物
		int foodCount = Random.Range(2, gameManager.level+1);
		InstantiateItems(foodCount, foodArray);
		//创建敌人
		int enemyCount = gameManager.level/2;
		InstantiateItems(enemyCount, enemyArray);
		//创建出口
		GameObject exitObj = GameObject.Instantiate(exitPrefab, new Vector2(cols-2,rows-2),Quaternion.identity) as GameObject;
		exitObj.transform.SetParent(mapHolder);
	}

	private void InstantiateItems(int count, GameObject[] prefabs){
		for(int i=0;i<count;i++){
			Vector2 pos = RandomPosition();
			GameObject prefab = RandomPrefab(prefabs);
			GameObject go = GameObject.Instantiate(prefab, pos,Quaternion.identity) as GameObject;
			go.transform.SetParent(mapHolder);
		}
	}

	private Vector2 RandomPosition(){
		int positionIndex = Random.Range(0, positionList.Count);
		Vector2 pos = positionList[positionIndex];
		positionList.RemoveAt(positionIndex);
		return pos;
	}

	private GameObject RandomPrefab(GameObject[] prefabs){
		int index = Random.Range(0,prefabs.Length);
		return prefabs[index];
	}
}
