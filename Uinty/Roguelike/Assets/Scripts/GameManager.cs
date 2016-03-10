using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;

public class GameManager : MonoBehaviour {

	private static GameManager _instance;
	private bool sleepStep = true;
	private Text foodText;
	private Text failText;
	private MapManager mapManager;
	private Image dayImage;
	private Text dayText;

	public static GameManager Instance {
		get {
			return _instance;
		}
	}

	public int level = 1;
	public int food = 100;
	public bool isEnd = false;
	public List<Enemy> enemyList = new List<Enemy>();

	void Awake () {
		_instance = this;
		DontDestroyOnLoad(gameObject);
		InitGame();
	}

	void InitGame(){
		enemyList.Clear();
		isEnd = false;

		//初始化地图
		mapManager = GetComponent<MapManager>();
		mapManager.InitMap();

		foodText = GameObject.Find("FoodText").GetComponent<Text>();
		failText = GameObject.Find("FailText").GetComponent<Text>();
		failText.enabled = false;
		UpdateFoodText(0);
		dayImage = GameObject.Find("DayImage").GetComponent<Image>();
		dayText = GameObject.Find("DayText").GetComponent<Text>();
		dayText.text = "Day "+level;
		Invoke("HideBlack",1);
	}

	void UpdateFoodText(int foodChange){
		if(foodChange == 0){
			foodText.text = "Food:"+food;
		}else{
			string str = "";
			if(foodChange<0){
				str = foodChange.ToString();
			}else{
				str = "+"+foodChange;
			}
			foodText.text = str+"  Food:"+food;
		}

	}
	
	public void AddFood(int count){
		food += count;
		UpdateFoodText(count);
	}

	public void ReduceFood(int count){
		food -= count;
		UpdateFoodText(-count);
		if(food<=0){
			failText.enabled = true;
		}
	}

	public void OnPlayerMove(){
		if(sleepStep == true){
			sleepStep = false;
		}else{
			foreach(var enemy in enemyList){
				enemy.Move();
			}
			sleepStep = true;
		}
	}

	public void NewGame(){
		Application.LoadLevel(Application.loadedLevel);
	}

	void OnLevelWasLoaded(int sceneLevel){
		level++;
		InitGame();
	}

	void HideBlack(){
		dayImage.gameObject.SetActive(false);
	}
}
